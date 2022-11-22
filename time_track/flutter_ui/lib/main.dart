import 'package:flutter/material.dart';
import 'package:realm_dart/realm.dart';

import 'edit_list_page.dart';
import 'login_page.dart';
import 'mongo_style.dart' as mongo;

void main() {
  Realm.logger.level = RealmLogLevel.trace;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mongo.lightTheme,
      darkTheme: mongo.darkTheme,
      title: 'Time Track',
      // navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (_) => const LoginPage(),
        EditListPage.routeName: (_) => const EditListPage(),
      },
    );
  }
}
