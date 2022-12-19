import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_todo/realm/realm_services.dart';
import 'package:flutter_todo/theme.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_todo/realm/app_services.dart';
import 'package:flutter_todo/screens/homepage.dart';
import 'package:flutter_todo/screens/log_in.dart';

import 'components/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final realmConfig = json.decode(await rootBundle.loadString('assets/config/realm.json'));
  String appId = realmConfig['appId'];
  Uri baseUrl = Uri.parse(realmConfig['baseUrl']);


  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppServices>(create: (_) => AppServices(appId, baseUrl)),
    ChangeNotifierProxyProvider<AppServices, RealmServices?>(
        // RealmServices can only be initialized only if the user is logged in.
        create: (context) => null,
        update: (BuildContext context, AppServices appServices, RealmServices? realmServices) {
          return appServices.app.currentUser != null ? RealmServices(appServices.app) : null;
        }),
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<RealmServices?>(context, listen: false)?.currentUser;

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        title: 'Realm Flutter Todo',
        theme: appThemeData(),
        initialRoute: currentUser != null ? '/' : '/login',
        routes: {'/': (context) => const HomePage(), '/login': (context) => LogIn()},
      ),
    );
  }
}


