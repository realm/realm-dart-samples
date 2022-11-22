import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:realm_dart/realm.dart';

import 'edit_list_page.dart';
import 'providers.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  Future<String?> _loginUser(LoginData data) async {
    try {
      final credentials = Credentials.emailPassword(data.name, data.password);
      await app.logIn(credentials);
      return null; // success;
    } catch (e) {
      return 'Login failed: $e';
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      final authProvider = app.emailPasswordAuthProvider;
      await authProvider.registerUser(data.name!, data.password!);
      return null; // success;
    } catch (e) {
      return 'Signup failed: $e';
    }
  }

  Future<String?> _recoverPassword(String name) async {
    try {
      final authProvider = app.emailPasswordAuthProvider;
      await authProvider.resetPassword(name);
      return null; // success;
    } catch (e) {
      return 'Recover failed: $e';
    }
  }

  Future<String?> _signupConfirm(String error, LoginData data) async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: FlutterLogin(
        title: 'Time Track',
        logo: const AssetImage('assets/images/mongodb_logo_forrest_green.png'),
        navigateBackAfterRecovery: true,
        initialAuthMode: AuthMode.login,
        userValidator: (value) {
          if (value.isNullOrEmpty) return 'Email is empty';
          if (!value!.isValidEmail) return 'Not a valid email';
          return null; // success;
        },
        passwordValidator: (value) {
          if (value.isNullOrEmpty) return 'Password is empty';
          if (!value!.isValidPassword) return 'Password must be 6 to 128 characters long';
          return null; // success;
        },
        onLogin: _loginUser,
        onSignup: _signupUser,
        onConfirmSignup: _signupConfirm,
        onRecoverPassword: _recoverPassword,
        onSubmitAnimationCompleted: () async {
          await Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (_, __, ___) => const EditListPage(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: RotationTransition(
                    turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
        theme: LoginTheme(
          pageColorLight: colorScheme.background,
          pageColorDark: colorScheme.background, // no gradient
          accentColor: colorScheme.onBackground,
          buttonStyle: TextStyle(color: colorScheme.onSecondary),
          buttonTheme: LoginButtonTheme(backgroundColor: colorScheme.secondary),
        ),
      ),
    );
  }
}

extension on String {
  static final _email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  bool get isValidEmail => _email.hasMatch(this);

  static final _password = RegExp(r'.{6,128}');
  bool get isValidPassword => _password.hasMatch(this);
}

extension on String? {
  bool get isNullOrEmpty {
    final self = this;
    return self == null || self.isEmpty;
  }
}
