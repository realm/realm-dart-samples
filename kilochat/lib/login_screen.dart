import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

import 'providers.dart';
import 'router.dart';
import 'settings.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

enum PageMode { registration, login, loggedIn }

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();

  PageMode _mode = PageMode.registration;
  PageMode get mode => _mode;
  set mode(PageMode mode) => setState(() => _mode = mode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 50, top: 10, bottom: 10),
                child: Text(
                  'Sign in using passkey',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextField(
                  autofillHints: const [AutofillHints.email],
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email address',
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: _buildButton(),
              ),
              const SizedBox(height: 16),
              _buildSwitchMode()
            ],
          ),
        ),
      ),
    );
  }

  String _buttonText() {
    return switch (mode) {
      PageMode.registration => 'sign up',
      PageMode.login => 'sign in',
      PageMode.loggedIn => 'logout',
    };
  }

  Widget _buildButton() =>
      ElevatedButton(onPressed: _onClick, child: Text(_buttonText()));

  Widget _buildActionSpan(String lead, String action, PageMode newMode) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: lead,
            style: const TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: action,
            style: TextStyle(color: Theme.of(context).primaryColor),
            recognizer: TapGestureRecognizer()..onTap = () => mode = newMode,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchMode() {
    return switch (mode) {
      PageMode.registration => _buildActionSpan(
          'Already have an account? ',
          'Sign in',
          PageMode.login,
        ),
      PageMode.login => _buildActionSpan(
          'First time here? ',
          'Sign up',
          PageMode.registration,
        ),
      PageMode.loggedIn => const Text('You are currently logged in.'),
    };
  }

  Future<void> _onClick() async {
    final auth = await ref.watch(authProvider.future);
    final email = _emailController.value.text;

    try {
      final app = currentWorkspace!.app;
      if (mode == PageMode.loggedIn) {
        app.currentUser?.logOut();
        mode = PageMode.login;
      } else {
        if (mode == PageMode.registration) {
          await auth.signUpWithPasskey(email: email);
        } else if (mode == PageMode.login) {
          await auth.loginWithPasskey(email: email);
        }
        final jwt = (await auth.currentUser)!.idToken;
        await currentWorkspace?.app.logIn(Credentials.jwt(jwt));
        mode = PageMode.loggedIn;

        if (mounted) Routes.chat.go(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Text(e.toString()),
            duration: const Duration(seconds: 10),
          ),
        );
      }
    }
  }
}
