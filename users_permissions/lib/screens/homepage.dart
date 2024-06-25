import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo/components/todo_list.dart';
import 'package:flutter_todo/components/create_item.dart';
import 'package:flutter_todo/components/app_bar.dart';
import 'package:flutter_todo/realm/realm_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<RealmServices?>(context, listen: false) == null
        ? Container()
        : const Scaffold(
      appBar: TodoAppBar(),
      body: TodoList(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: CreateItemAction(),
    );
  }
}
