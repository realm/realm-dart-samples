import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kilochat/providers.dart';
import 'package:passkeys/relying_party_server/corbado/types/shared.dart';
import 'package:realm/realm.dart';

import 'realm_ui/realm_animated_list.dart';
import 'router.dart';
import 'settings.dart';

class WorkspaceView extends ConsumerWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RealmAnimatedList(
      results: workspaces,
      itemBuilder: (context, item, animation) {
        return ListTile(
          onTap: () {
            currentWorkspace = item;
            Routes.chat.go(context);
          }, // change workspace
          onLongPress: () => showDialog(
            context: context,
            builder: (_) {
              return WorkspaceForm(initialWorkspace: item); // edit workspace
            },
          ),
          title: Text('# ${item.name}'),
        );
      },
    );
  }
}

class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const WorkspaceView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return const Dialog(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Wrap(children: [WorkspaceForm()]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class WorkspaceForm extends StatefulWidget {
  const WorkspaceForm({
    super.key,
    this.initialWorkspace,
  });

  final Workspace? initialWorkspace;

  @override
  State<WorkspaceForm> createState() => _WorkspaceFormState();
}

class _WorkspaceFormState extends State<WorkspaceForm> {
  final formKey = GlobalKey<FormState>();
  late final Workspace workspace;

  @override
  void initState() {
    workspace = Workspace(
      widget.initialWorkspace?.appId ?? '',
      widget.initialWorkspace?.name ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Create a workspace'),
          const SizedBox(height: 4),
          TextFormField(
            decoration: const InputDecoration(labelText: 'name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name to display';
              }
              return null;
            },
            onSaved: (newValue) {
              workspace.name = newValue!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'appId'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid Atlas App ID';
              }
              return null;
            },
            onSaved: (newValue) {
              workspace.appId = newValue!;
            },
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  final state = formKey.currentState!;
                  if (state.validate()) {
                    state.save();
                    addOrUpdateWorkspace(workspace);
                    currentWorkspace = workspace;
                    // TODO: save workspace
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
        AuthResponse? response;
        if (mode == PageMode.registration) {
          response = await auth.registerWithEmail(AuthRequest(email));
        } else if (mode == PageMode.login) {
          response = await auth.authenticateWithEmail(AuthRequest(email));
        }
        await currentWorkspace?.app.logIn(Credentials.jwt(response!.token));
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
