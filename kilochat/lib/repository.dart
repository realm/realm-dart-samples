import 'dart:async';
import 'dart:io';

import 'package:cancellation_token/cancellation_token.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:realm/realm.dart';

import 'model.dart';

class Disposable {
  final List<Function> _disposers = [];

  Future<void> dispose() async {
    for (final disposer in _disposers) {
      await disposer();
    }
  }

  void onDispose(Function disposer) => _disposers.add(disposer);
}

class Repository extends Disposable {
  final Realm _realm;
  final User _user;

  late final UserProfile userProfile =
      _realm.findOrAdd(_user.id, (id) => UserProfile(id, id));

  Repository(this._realm, this._user) {
    // force logout, and drop local data, user deactivated
    userProfile.changes.asyncListen((change) async {
      if (change.isDeleted || change.object.deactivated) {
        await _user.app.removeUser(_user);
      }
    }).cancelOnDisposeOf(this);

    // monitor a users selected channels and update subscriptions accordingly,
    // on all devices.
    userProfile.channels
        .asResults() // indexes are off otherwise
        .changes
        .updateSubscriptions() // add or drop subscriptions
        .listen((_) {})
        .cancelOnDisposeOf(this);

    // try to reconnect on any network change, to wake up as early as possible
    Connectivity()
        .onConnectivityChanged
        .listen((_) => _user.app.reconnect())
        .cancelOnDisposeOf(this);
  }

  static Future<Repository> init(User user) async {
    return Repository(await _initRealm(user), user);
  }

  static Future<Realm> _initRealm(User user) async {
    final config = Configuration.flexibleSync(
      user,
      [
        Channel.schema,
        Message.schema,
        Reaction.schema,
        UserProfile.schema,
      ],
    );
    late Realm realm;
    final ct = TimeoutCancellationToken(const Duration(seconds: 30));
    try {
      if (await File(config.path).exists()) {
        realm = Realm(config);
      } else {
        realm = await Realm.open(config, cancellationToken: ct);
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

  Session get session => _realm.syncSession;

  late RealmResults<Channel> allChannels =
      _realm.query<Channel>('TRUEPREDICATE SORT(name ASCENDING)');

  RealmResults<Channel> searchChannel(String name) {
    return _realm.query<Channel>(
      r'name CONTAINS $0 SORT(name ASCENDING)',
      [name],
    );
  }

  Channel createChannel(String name) => _realm
      .write(() => _realm.add(Channel(ObjectId(), userProfile.id, name, 0)));

  void subscribeToChannel(Channel channel) =>
      _realm.write(() => userProfile.channels.add(channel));

  void unsubscribeFromChannel(Channel channel) =>
      _realm.write(() => userProfile.channels.remove(channel));

  void deleteChannel(Channel channel) =>
      _realm.write(() => _realm.delete(channel));

  late RealmResults<Message> allMessages =
      _realm.query<Message>('TRUEPREDICATE SORT(id DESCENDING)');

  RealmResults<Message> messages(Channel channel) => _realm
      .query<Message>(r'channel == $0 SORT(index DESC, id ASC)', [channel]);

  RealmResults<Message> searchMessage(String text) {
    if (text.isEmpty) return allMessages;
    return _realm.query<Message>(
      r'text TEXT $0 SORT(id DESCENDING)',
      [text],
    );
  }

  late Stream<Message> x =
      allMessages.changes.where((c) => c.inserted.isNotEmpty).map((c) {
    return c.results[c.inserted.last];
  });

  void postNewMessage(Channel channel, String text) {
    // messages are sorted latest first
    final lastMessage = messages(channel).firstOrNull;
    if (lastMessage != null &&
        lastMessage.owner == userProfile &&
        lastMessage.reactions.isEmpty) {
      // if we own last message, and there are no reactions, then update in place
      final newText = '${lastMessage.text}\n\n$text';
      editMessage(lastMessage, newText);
    } else {
      _realm.write(() {
        // create new message with highest local index
        // NOTE: Index may be duplicated if multiple clients are posting at once
        _realm.add(Message(
          ObjectId(),
          (lastMessage?.index ?? 0) + 1, // increment index
          userProfile.id,
          channel.id, // not a link
          text,
          channel: channel,
          owner: userProfile,
        ));
      });
    }
  }

  void editMessage(Message message, String text) =>
      _realm.write(() => message.text = text);

  void deleteMessage(Message message) =>
      _realm.write(() => _realm.delete(message));

  void addReaction(Message message, String emoji) =>
      _realm.addOrUpdate(ReactionEx.create(userProfile, message, emoji));

  void deleteReaction(Reaction reaction) =>
      _realm.write(() => _realm.delete(reaction));

  void updateUserProfile(UserProfile newProfile) =>
      _realm.write(() => _realm.add(newProfile, update: true));
}

extension on MutableSubscriptionSet {
  void subscribe(Channel channel) => add(
        name: '${channel.id}',
        channel.realm.query<Message>(r'channelId == $0', [channel.id]),
        update: true,
      );
  void unsubscribe(Channel channel) => removeByName('${channel.id}');
}

extension on Stream<RealmResultsChanges<Channel>> {
  Stream<RealmResultsChanges<Channel>> updateSubscriptions() async* {
    RealmResults<Channel>? previous;
    await for (final change in this) {
      final results = change.results;
      results.realm.subscriptions.update((mutableSubscriptions) {
        if (previous != null) {
          for (final i in change.deleted.reversed) {
            mutableSubscriptions.unsubscribe(previous!.elementAt(i));
          }
          for (final i in change.inserted) {
            mutableSubscriptions.subscribe(results.elementAt(i));
          }
        } else {
          // first time
          for (final channel in results) {
            mutableSubscriptions.subscribe(channel);
          }
        }
        previous = results.freeze();
      });
      yield change;
    }
  }
}

extension on StreamSubscription {
  void cancelOnDisposeOf(Disposable disposable) => disposable.onDispose(cancel);
}

extension<T> on Stream<T> {
  StreamSubscription<void> asyncListen(
    Future<void> Function(T) onData, {
    Function? onError,
    void Function()? onDone,
  }) =>
      asyncMap(onData).listen((_) {}, onError: onError, onDone: onDone);
}

extension RealmEx on Realm {
  T addOrUpdate<T extends RealmObject>(T object) =>
      write(() => add(object, update: true));

  T findOrAdd<T extends RealmObject, I>(I id, T Function(I id) factory) =>
      write(() => find(id) ?? add(factory(id)));
}
