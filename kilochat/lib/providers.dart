import 'dart:async';

import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'firebase_user_provider.dart';
import 'model.dart';
import 'repository.dart';
import 'settings.dart';

part 'providers.g.dart';

@riverpod
Stream<App> app(AppRef ref) async* {
  await for (final ws in workspaceChanges) {
    if (ws == null) continue;
    yield ws.app;
  }
}

@riverpod
Stream<User> user(UserRef ref) async* {
  final app = await ref.watch(appProvider.future);

  final firebaseUser = await ref.watch(firebaseUserProvider.future);
  final jwt = await firebaseUser?.getIdToken(true); // force refresh

  var user = app.currentUser;
  if (jwt != null) {
    user = await app.logIn(Credentials.jwt(jwt));
    yield user;
  }
}

@riverpod
Future<Repository> repository(RepositoryRef ref) async {
  final user = await ref.watch(userProvider.future);
  final repo = await Repository.init(user);
  ref.onDispose(repo.dispose);
  return repo;
}

class FocusedChannel extends Notifier<Channel?> {
  @override
  Channel? build() => null;

  void focus(Channel channel) => state = channel;
}

final focusedChannelProvider =
    NotifierProvider<FocusedChannel, Channel?>(FocusedChannel.new);
