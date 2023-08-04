import 'dart:async';

import 'package:kilochat/providers.dart';
import 'package:realm/realm.dart';

import 'model.dart';

extension on MutableSubscriptionSet {
  void subscribe(Channel channel) => add(
        name: '${channel.id}',
        channel.realm.query<Message>(r'channelId == $0', [channel.id]),
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

class Repository {
  final Realm _realm;
  final UserProfile user;
  final StreamSubscription _subscription;

  Repository(this._realm, this.user)
      : _subscription = user.channels
            .asResults()
            .changes
            .updateSubscriptions()
            .listen((_) {});

  late RealmResults<Channel> allChannels =
      _realm.query<Channel>('TRUEPREDICATE SORT(name ASCENDING)');

  late RealmResults<Message> allMessages =
      _realm.query<Message>('TRUEPREDICATE SORT(id DESCENDING)');

  RealmResults<Message> messages(Channel channel) => _realm
      .query<Message>(r'channel == $0 SORT(index DESC, id ASC)', [channel]);

  late Stream<Message> x =
      allMessages.changes.where((c) => c.inserted.isNotEmpty).map((c) {
    return c.results.first;
  });

  void updateUserProfile(UserProfile newProfile) =>
      _realm.write(() => _realm.add(newProfile, update: true));

  void postNewMessage(Channel channel, String text) {
    // messages are sorted latest first
    final lastMessage = messages(channel).firstOrNull;
    if (lastMessage != null &&
        lastMessage.owner == user &&
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
          user.id,
          channel.id, // not a link
          text,
          channel: channel,
          owner: user,
        ));
      });
    }
  }

  void editMessage(Message message, String text) =>
      _realm.write(() => message.text = text);

  void deleteMessage(Message message) =>
      _realm.write(() => _realm.delete(message));

  RealmResults<Message> searchMessage(String text) {
    if (text.isEmpty) return allMessages;
    return _realm.query<Message>(
      r'text TEXT $0 SORT(id DESCENDING)',
      [text],
    );
  }

  void addReaction(Message message, String emoji) =>
      _realm.addOrUpdate(ReactionEx.create(user, message, emoji));

  void deleteReaction(Reaction reaction) =>
      _realm.write(() => _realm.delete(reaction));

  Channel createChannel(String name) =>
      _realm.write(() => _realm.add(Channel(ObjectId(), user.id, name, 0)));

  void subscribeToChannel(Channel channel) =>
      _realm.write(() => user.channels.add(channel));

  void unsubscribeFromChannel(Channel channel) =>
      _realm.write(() => user.channels.remove(channel));

  void deleteChannel(Channel channel) =>
      _realm.write(() => _realm.delete(channel));

  RealmResults<Channel> searchChannel(String name) {
    return _realm.query<Channel>(
      r'name CONTAINS $0 SORT(name ASCENDING)',
      [name],
    );
  }
}

extension RealmEx on Realm {
  T findOrAdd<T extends RealmObject, I>(I id, T Function(I id) factory) =>
      write(() => find(id) ?? add(factory(id)));

  T addOrUpdate<T extends RealmObject>(T object) =>
      write(() => add(object, update: true));
}
