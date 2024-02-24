import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'chat_screen.dart';
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
  initialLocation: Routes.chat.path, // redirect will fix if needed
  routes: [
    GoRoute(
      path: Routes.chat.path,
      builder: (_, __) => const ChatScreen(),
    ),
    GoRoute(
      path: Routes.chooseWorkspace.path,
      builder: (_, __) => const WorkspaceScreen(),
    ),
    GoRoute(
      path: Routes.logIn.path,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: Routes.profile.path,
      builder: (context, state) {
        return const Placeholder();
      },
    ),
  ],
  redirect: (context, state) async {
    // always okay to switch to workspace selection
    if (state.fullPath == Routes.chooseWorkspace.path) return null;

    // check if workspace or log in is needed
    final ws = currentWorkspace;
    return ws == null
        ? Routes.chooseWorkspace.path // no workspace, so choose one
        : (ws.app.currentUser == null // no user, so log in
            ? Routes.logIn.path
            : null); // otherwise, navigation okay
  },
);
