import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'router.dart';

const freedomBlue = Color(0xff0057b7);
const energizingYellow = Color(0xffffd700);

Future<void> main() async {
  Animate.restartOnHotReload = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    AppleProvider(),
    FacebookProvider(clientId: ''),
    GoogleProvider(clientId: ''),
  ]);
  runApp(
    ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: freedomBlue,
            inversePrimary: energizingYellow,
          ),
        ),
      ),
    ),
  );
}
