import 'package:flutter/material.dart';
import 'package:flutter_todo/components/todo_item.dart';
import 'package:flutter_todo/components/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo/realm/realm_services.dart';
import 'package:realm/realm.dart';
import 'package:flutter_todo/theme.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    return Stack(
      children: [
        Column(
          children: [
            styledBox(context,
                isHeader: true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Role: ${(realmServices.currentUser?.isAdmin ?? false) ? "Administrator" : " User"}",
                            style: importantTextStyle(context), textAlign: TextAlign.left),
                        const Expanded(
                          child: Text("Show All Tasks", textAlign: TextAlign.right),
                        ),
                        Switch(
                          value: realmServices.showAll,
                          onChanged: (value) async {
                            if (realmServices.offlineModeOn) {
                              infoMessageSnackBar(context, "Switching subscriptions does not affect Realm data when the sync is offline.").show(context);
                            }
                            await realmServices.switchSubscription(value);
                          },
                        ),
                      ],
                    ),
                    Row(children: [
                      Text(
                        (realmServices.currentUser?.isAdmin ?? false)
                            ? realmServices.showAll
                                ? "Full permissions to edit/delete all users`s tasks."
                                : ""
                            : realmServices.showAll
                                ? "Editing other users` tasks is not allowed."
                                : "",
                        textAlign: TextAlign.left,
                        style: importantTextStyle(context),
                      ),
                    ]),
                  ],
                )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: StreamBuilder<RealmResultsChanges<Item>>(
                  stream: realmServices.realm
                      .query<Item>("TRUEPREDICATE SORT(_id ASC)")
                      .changes,
                  builder: (context, snapshot) {
                    final data = snapshot.data;

                    if (data == null) return waitingIndicator();

                    final results = data.results;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.realm.isClosed ? 0 : results.length,
                      itemBuilder: (context, index) => results[index].isValid
                          ? TodoItem(results[index])
                          : Container(),
                    );
                  },
                ),
              ),
            ),
            styledBox(
              context,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 40, 15),
                  child: const Text(
                    "Log in with the same account on another device to see your list sync in realm-time.",
                    textAlign: TextAlign.left,
                  )),
            ),
          ],
        ),
        realmServices.isWaiting ? waitingIndicator() : Container(),
      ],
    );
  }
}
