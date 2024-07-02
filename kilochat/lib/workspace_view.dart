import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  const WorkspaceScreen({super.key});

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
    super.initState();
    workspace = Workspace(
      widget.initialWorkspace?.appId ?? '',
      widget.initialWorkspace?.name ?? '',
    );
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

