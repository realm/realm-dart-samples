import 'dart:async';

import 'package:corbado_auth/corbado_auth.dart';
import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'model.dart';
import 'repository.dart';
import 'settings.dart';

part 'providers.g.dart';

@riverpod
Future<CorbadoAuth> auth(AuthRef ref) async {
  //const projectId = 'pro-2636186146982821243';
  const projectId = 'pro-9092673961474177526';
  final auth = CorbadoAuth();
  await auth.init(projectId);
  return auth;
}

@riverpod
Stream<Repository> repository(RepositoryRef ref) async* {
  await for (final ws in workspaceChanges) {
    if (ws == null) continue; // no workspace selected, so no repository

    final user = ws.app.currentUser;
    if (user == null) continue; // no user logged in, so no repository

    final repository = await Repository.init(ws);
    ref.onDispose(repository.dispose);
    yield repository;
  }
}

@riverpod
Stream<Channel?> focusedChannel(FocusedChannelRef ref) async* {
  final repository = await ref.watch(repositoryProvider.future);
  await for (final channel in repository.focusedChannelChanges) {
    yield channel?.nullIfInvalid;
  }
}

extension<T extends RealmObject> on T {
  T? get nullIfInvalid => isValid ? this : null;
}
