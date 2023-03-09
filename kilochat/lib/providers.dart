import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:realm/realm.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'model.dart';
import 'repository.dart';

part 'providers.g.dart';

final firebaseUserProvider = StateProvider<firebase.User?>(
  (ref) => firebase.FirebaseAuth.instance.currentUser,
);

class FocusedChannel extends Notifier<Channel?> {
  @override
  Channel? build() => null;

  void focus(Channel channel) => state = channel;
}

final focusedChannelProvider =
    NotifierProvider<FocusedChannel, Channel?>(FocusedChannel.new);

@riverpod
Stream<App> app(AppRef ref) async* {
  final app = App(AppConfiguration('kilochat-app-ighux'));
  yield app;
  await for (final _ in Connectivity().onConnectivityChanged) {
    app.reconnect();
  }
}

@riverpod
Future<Realm> localRealm(LocalRealmRef ref) async =>
    await Realm.open(Configuration.local([]));

@riverpod
Stream<RealmResults<Message>> messages(
  MessagesRef ref,
  Channel? channel,
) async* {
  final repository = await ref.watch(repositoryProvider.future);
  if (channel == null) return;
  yield repository.messages(channel);
}

@riverpod
Future<Repository> repository(RepositoryRef ref) async {
  final realm = await ref.watch(syncedRealmProvider.future);
  final user = await ref.watch(userProfileProvider.future);
  return Repository(realm, user);
}

@riverpod
Future<Realm> syncedRealm(SyncedRealmRef ref) async {
  final user = await ref.watch(userProvider.future);
  final realm = await Realm.open(Configuration.flexibleSync(
    user,
    [
      Channel.schema,
      Message.schema,
      Reaction.schema,
      UserProfile.schema,
    ],
  ));
  realm.subscriptions.update((mutableSubscriptions) {
    mutableSubscriptions
      ..add(realm.all<Channel>())
      ..add(realm.all<Message>())
      ..add(realm.all<Reaction>())
      ..add(realm.all<UserProfile>());
  });
  await realm.subscriptions.waitForSynchronization();
  await realm.syncSession.waitForDownload();
  return realm;
}

@riverpod
Stream<User> user(UserRef ref) async* {
  final app = await ref.watch(appProvider.future);
  final firebaseUser = ref.watch(firebaseUserProvider);

  var user = app.currentUser;
  if (user == null) {
    if (firebaseUser != null) {
      final jwt = await firebaseUser.getIdToken();
      user = await app.logIn(Credentials.jwt(jwt));
    }
  }
  if (user != null) yield user;
}

@riverpod
Stream<UserProfile> userProfile(UserProfileRef ref) async* {
  final user = await ref.watch(userProvider.future);
  final realm = await ref.watch(syncedRealmProvider.future);
  final userProfile = realm.findOrAdd(
    user.id,
    (id) {
      return UserProfile(id, id);
    },
  );
  yield userProfile;
  await for (final change in userProfile.changes) {
    final deactivated = !change.isDeleted && change.object.deactivated;
    if (deactivated) {
      try {
        await user.app.removeUser(user);
        await firebase.FirebaseAuth.instance.signOut();
      } finally {
        exit(64);
      }
    }
  }
}
