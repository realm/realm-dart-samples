import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class AppServices with ChangeNotifier {
  String id;
  Uri baseUrl;
  App app;
  User? currentUser;
  AppServices(this.id, this.baseUrl)
      : app = App(AppConfiguration(id, baseUrl: baseUrl));

  Future<User> logInUserEmailPassword(String email, String password) async {
    User loggedInUser =
        await app.logIn(Credentials.emailPassword(email, password));
    currentUser = loggedInUser;
    notifyListeners();
    return loggedInUser;
  }

  Future<User> registerUserEmailPassword(String email, String password) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    await authProvider.registerUser(email, password);
    User loggedInUser =
        await app.logIn(Credentials.emailPassword(email, password));
    currentUser = loggedInUser;
    notifyListeners();
    return loggedInUser;
  }

  Future<void> logOut() async {
    await currentUser?.logOut();
    currentUser = null;
  }
}
