import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

import 'router.dart';

const freedomBlue = Color(0xff0057b7);
const energizingYellow = Color(0xffffd700);

Future<void> main() async {
  Realm.logger.level = RealmLogLevel.debug;
  Animate.restartOnHotReload = true;
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: freedomBlue,
            inversePrimary: energizingYellow,
          ),
        ),
      ),
    ),
  );
}
