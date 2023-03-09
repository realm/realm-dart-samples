import 'package:realm/realm.dart';

import 'model.dart';

class Repository {
  final Realm _realm;
  final UserProfile user;

  Repository(this._realm, this.user);

  late RealmResults<Channel> allChannels =
      _realm.query<Channel>('TRUEPREDICATE SORT(name ASCENDING)');

  late RealmResults<Message> allMessages =
      _realm.query<Message>('TRUEPREDICATE SORT(id DESCENDING)');

  RealmResults<Message> messages(Channel channel) =>
      _realm.query<Message>(r'channel == $0 SORT(id DESCENDING)', [channel]);

  void updateUserProfile(UserProfile newProfile) =>
      _realm.write(() => _realm.add(newProfile, update: true));

  void postNewMessage(Channel channel, String text) {
    _realm.write(() {
      _realm.add(Message(
        ObjectId(),
        user.id,
        channel.id, // not a link
        text,
        channel: channel,
        owner: user,
      ));
    });
  }

  void editMessage(Message message, String text) =>
      _realm.write(() => message.text = text);

  void deleteMessage(Message message) =>
      _realm.write(() => _realm.delete(message));

  RealmResults<Message> searchMessage(String text) {
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
