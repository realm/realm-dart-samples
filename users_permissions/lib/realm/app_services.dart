import 'package:flutter/material.dart';
import 'package:flutter_todo/realm/schemas.dart';
import 'package:realm/realm.dart';

class AppServices with ChangeNotifier {
  String id;
  Uri baseUrl;
  App app;
  User? currentUser;
  AppServices(this.id, this.baseUrl) : app = App(AppConfiguration(id, baseUrl: baseUrl));

  Future<User> logInUserEmailPassword(String email, String password) async {
    User loggedInUser = await app.logIn(Credentials.emailPassword(email, password));
    currentUser = loggedInUser;
    notifyListeners();
    return loggedInUser;
  }

  Future<User> registerUserEmailPassword(String email, String password, bool isAdmin) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    await authProvider.registerUser(email, password);
    User loggedInUser = await app.logIn(Credentials.emailPassword(email, password));
    await setRole(loggedInUser, isAdmin);
    loggedInUser.logOut();
    return loggedInUser;
  }

  Future<void> setRole(User loggedInUser, bool isAdmin) async {
    final realm = Realm(Configuration.flexibleSync(loggedInUser, [Role.schema, Item.schema]));
    realm.subscriptions.update((mutableSubscriptions) => mutableSubscriptions.add(realm.all<Role>()));
    await realm.subscriptions.waitForSynchronization();
    realm.write(() => realm.add(Role(ObjectId(), loggedInUser.id, isAdmin: isAdmin)));
    await realm.syncSession.waitForUpload();
    realm.close();
  }

  Future<void> logOut() async {
    await currentUser?.logOut();
    currentUser = null;
  }
}
