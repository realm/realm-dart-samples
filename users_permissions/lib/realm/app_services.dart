import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class AppServices with ChangeNotifier {
  String id;
  App app;
  User? currentUser;
  AppServices(this.id) : app = App(AppConfiguration(id));

  Future<User> logInUserEmailPassword(String email, String password) async {
    User loggedInUser = await app.logIn(Credentials.emailPassword(email, password));
    currentUser = loggedInUser;
    notifyListeners();
    return loggedInUser;
  }

  Future<User> registerUserEmailPassword(String email, String password) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    await authProvider.registerUser(email, password);
    User loggedInUser = await app.logIn(Credentials.emailPassword(email, password));
    await setRole(loggedInUser);
    await loggedInUser.refreshCustomData();
    currentUser = loggedInUser;
    notifyListeners();
    return loggedInUser;
  }

  Future<void> setRole(User loggedInUser) async {
    final realm = Realm(Configuration.flexibleSync(loggedInUser, [Role.schema, Item.schema]));
    String subscriptionName = "rolesSubscription";
    realm.subscriptions.update((mutableSubscriptions) => mutableSubscriptions.add(realm.all<Role>(), name: subscriptionName));
    await realm.subscriptions.waitForSynchronization();
    realm.write(() => realm.add(Role(ObjectId(), loggedInUser.id, isAdmin: false)));
    await realm.syncSession.waitForUpload();
    realm.subscriptions.update((mutableSubscriptions) => mutableSubscriptions.removeByName(subscriptionName));
    await realm.subscriptions.waitForSynchronization();
    await realm.syncSession.waitForDownload();
    realm.close();
  }

  Future<void> logOut() async {
    await currentUser?.logOut();
    currentUser = null;
  }
}
