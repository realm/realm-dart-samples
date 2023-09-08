import 'dart:async';

import 'package:passkeys/relying_party_server/corbado/corbado_passkey_backend.dart';
import 'package:passkeys/relying_party_server/corbado/types/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:passkeys/passkey_auth.dart';

import 'model.dart';
import 'repository.dart';
import 'settings.dart';

part 'providers.g.dart';

@riverpod
Future<PasskeyAuth<AuthRequest, AuthResponse>> auth(AuthRef ref) async {
  final server = CorbadoPasskeyBackend('pro-2636186146982821243');
  final auth = PasskeyAuth(server);
  if (await auth.isSupported()) {
    return auth;
  }
  throw Exception('Passkeys are not supported on this device!'); // TODO
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
    yield channel;
  }
}
