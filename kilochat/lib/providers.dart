import 'dart:async';
import 'dart:io';

import 'package:cancellation_token/cancellation_token.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:realm/realm.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'firebase_user_provider.dart';
import 'model.dart';
import 'repository.dart';
import 'settings.dart';

part 'providers.g.dart';

class FocusedChannel extends Notifier<Channel?> {
  @override
  Channel? build() => null;

  void focus(Channel channel) => state = channel;
}

final focusedChannelProvider =
    NotifierProvider<FocusedChannel, Channel?>(FocusedChannel.new);

@riverpod
Stream<App> app(AppRef ref) async* {
  StreamSubscription? subscription;
  await for (final ws in workspaceChanges) {
    subscription?.cancel();
    if (ws == null) continue;
    subscription = Connectivity().onConnectivityChanged.listen((_) {
      ws.app.reconnect();
    });
    yield ws.app;
  }
}

@riverpod
Future<Repository> repository(RepositoryRef ref) async {
  final realm = await ref.watch(syncedRealmProvider.future);
  final user = await ref.watch(userProfileProvider.future);
  final repo = Repository(realm, user);
  ref.onDispose(repo.dispose);
  return repo;
}

@riverpod
Future<Realm> syncedRealm(SyncedRealmRef ref) async {
  final user = await ref.watch(userProvider.future);
  var config = Configuration.flexibleSync(
    user,
    [
      Channel.schema,
      Message.schema,
      Reaction.schema,
      UserProfile.schema,
    ],
  );
  Realm.logger.level = RealmLogLevel.debug;
  late Realm realm;
  final ct = TimeoutCancellationToken(const Duration(seconds: 30));
  try {
    if (await File(config.path).exists()) {
      realm = Realm(config);
    } else {
      realm = await Realm.open(
        config,
        cancellationToken: ct,
        onProgressCallback: (progress) {
          final transferred = progress.transferredBytes;
          final transferable = progress.transferableBytes;
          print('Sync progress: $transferred / $transferable');
        },
      );
    }
  } catch (_) {
    realm = Realm(config);
  }
  try {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions
        ..add(realm.all<Channel>())
        ..add(realm.query<Message>('channelId == null'))
        ..add(realm.all<Reaction>())
        ..add(realm.all<UserProfile>());
    });
    // await realm.subscriptions.waitForSynchronization(ct); // does not support cancellation yet
    await realm.syncSession.waitForDownload(ct);
  } on TimeoutException catch (_) {} // ignore and proceed
  return realm;
}

@riverpod
Stream<User> user(UserRef ref) async* {
  final app = await ref.watch(appProvider.future);
  final firebaseUser = await ref.watch(firebaseUserProvider.future);

  var user = app.currentUser;
  if (user == null) {
    if (firebaseUser != null) {
      final jwt = await firebaseUser.getIdToken(true); // force refresh
      if (jwt != null) {
        user = await app.logIn(Credentials.jwt(jwt));
      }
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
