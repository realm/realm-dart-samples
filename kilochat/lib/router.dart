import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'chat_screen.dart';
import 'providers.dart';
import 'settings.dart';
import 'workspace_view.dart';

enum Routes {
  chat,
  chooseWorkspace,
  logIn,
  profile;

  String get name => '$this';
  String get path => '/$this';
}

extension RoutesX on Routes {
  go(BuildContext context) => context.go(path);
}

final router = GoRouter(
  initialLocation: currentWorkspace == null
      ? Routes.chooseWorkspace.path // no workspace, so choose one
      : (currentWorkspace!.app.currentUser == null // no user, so log in
          ? Routes.logIn.path
          : Routes.chat.path), // otherwise, go directly to chat
  routes: [
    GoRoute(
      path: Routes.chat.path,
      builder: (context, state) => const ChatScreen(),
    ),
    GoRoute(
        path: Routes.chooseWorkspace.path,
        builder: (context, state) {
          return const WorkspaceScreen();
        }),
    GoRoute(
      path: Routes.logIn.path,
      builder: (context, state) {
        return SignInScreen(actions: [
          AuthStateChangeAction<SignedIn>((context, state) async {
            final ref = ProviderScope.containerOf(context);
            final firebaseUserController =
                ref.read(firebaseUserProvider.notifier);
            firebaseUserController.state = state.user;
            Routes.chat.go(context);
          }),
        ]);
      },
    ),
    GoRoute(
      path: Routes.profile.path,
      builder: (context, state) {
        return const Placeholder();
        // return ProfileForm();
      },
    ),
  ],
);
