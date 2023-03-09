// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Channel extends _Channel with RealmEntity, RealmObjectBase, RealmObject {
  Channel(
    ObjectId id,
    String ownerId,
    String name,
    int count, {
    Channel? parent,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'owner_id', ownerId);
    RealmObjectBase.set(this, 'parent', parent);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'count', count);
  }

  Channel._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  Channel? get parent =>
      RealmObjectBase.get<Channel>(this, 'parent') as Channel?;
  @override
  set parent(covariant Channel? value) =>
      RealmObjectBase.set(this, 'parent', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get count => RealmObjectBase.get<int>(this, 'count') as int;
  @override
  set count(int value) => RealmObjectBase.set(this, 'count', value);

  @override
  Stream<RealmObjectChanges<Channel>> get changes =>
      RealmObjectBase.getChanges<Channel>(this);

  @override
  Channel freeze() => RealmObjectBase.freezeObject<Channel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Channel._);
    return const SchemaObject(ObjectType.realmObject, Channel, 'Channel', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
      SchemaProperty('parent', RealmPropertyType.object,
          optional: true, linkTarget: 'Channel'),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('count', RealmPropertyType.int),
    ]);
  }
}

class Message extends _Message with RealmEntity, RealmObjectBase, RealmObject {
  Message(
    ObjectId id,
    String ownerId,
    ObjectId channelId,
    String text, {
    UserProfile? owner,
    Channel? channel,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'owner_id', ownerId);
    RealmObjectBase.set(this, 'owner', owner);
    RealmObjectBase.set(this, 'channel_id', channelId);
    RealmObjectBase.set(this, 'channel', channel);
    RealmObjectBase.set(this, 'text', text);
  }

  Message._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  UserProfile? get owner =>
      RealmObjectBase.get<UserProfile>(this, 'owner') as UserProfile?;
  @override
  set owner(covariant UserProfile? value) =>
      RealmObjectBase.set(this, 'owner', value);

  @override
  ObjectId get channelId =>
      RealmObjectBase.get<ObjectId>(this, 'channel_id') as ObjectId;
  @override
  set channelId(ObjectId value) =>
      RealmObjectBase.set(this, 'channel_id', value);

  @override
  Channel? get channel =>
      RealmObjectBase.get<Channel>(this, 'channel') as Channel?;
  @override
  set channel(covariant Channel? value) =>
      RealmObjectBase.set(this, 'channel', value);

  @override
  String get text => RealmObjectBase.get<String>(this, 'text') as String;
  @override
  set text(String value) => RealmObjectBase.set(this, 'text', value);

  @override
  RealmResults<Reaction> get reactions {
    if (!isManaged) {
      throw RealmError('Using backlinks is only possible for managed objects.');
    }
    return RealmObjectBase.get<Reaction>(this, 'reactions')
        as RealmResults<Reaction>;
  }

  @override
  set reactions(covariant RealmResults<Reaction> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Message>> get changes =>
      RealmObjectBase.getChanges<Message>(this);

  @override
  Message freeze() => RealmObjectBase.freezeObject<Message>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Message._);
    return const SchemaObject(ObjectType.realmObject, Message, 'Message', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
      SchemaProperty('owner', RealmPropertyType.object,
          optional: true, linkTarget: 'UserProfile'),
      SchemaProperty('channelId', RealmPropertyType.objectid,
          mapTo: 'channel_id', indexType: RealmIndexType.regular),
      SchemaProperty('channel', RealmPropertyType.object,
          optional: true, linkTarget: 'Channel'),
      SchemaProperty('text', RealmPropertyType.string,
          indexType: RealmIndexType.fullText),
      SchemaProperty('reactions', RealmPropertyType.linkingObjects,
          linkOriginProperty: 'message',
          collectionType: RealmCollectionType.list,
          linkTarget: 'Reaction'),
    ]);
  }
}

class Reaction extends _Reaction
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Reaction(
    ObjectId id,
    String ownerId, {
    UserProfile? owner,
    Message? message,
    int emojiUnicode = 0,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Reaction>({
        'emojiUnicode': 0,
      });
    }
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'owner_id', ownerId);
    RealmObjectBase.set(this, 'owner', owner);
    RealmObjectBase.set(this, 'message', message);
    RealmObjectBase.set(this, 'emojiUnicode', emojiUnicode);
  }

  Reaction._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  UserProfile? get owner =>
      RealmObjectBase.get<UserProfile>(this, 'owner') as UserProfile?;
  @override
  set owner(covariant UserProfile? value) =>
      RealmObjectBase.set(this, 'owner', value);

  @override
  Message? get message =>
      RealmObjectBase.get<Message>(this, 'message') as Message?;
  @override
  set message(covariant Message? value) =>
      RealmObjectBase.set(this, 'message', value);

  @override
  int get emojiUnicode => RealmObjectBase.get<int>(this, 'emojiUnicode') as int;
  @override
  set emojiUnicode(int value) =>
      RealmObjectBase.set(this, 'emojiUnicode', value);

  @override
  Stream<RealmObjectChanges<Reaction>> get changes =>
      RealmObjectBase.getChanges<Reaction>(this);

  @override
  Reaction freeze() => RealmObjectBase.freezeObject<Reaction>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Reaction._);
    return const SchemaObject(ObjectType.realmObject, Reaction, 'Reaction', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
      SchemaProperty('owner', RealmPropertyType.object,
          optional: true, linkTarget: 'UserProfile'),
      SchemaProperty('message', RealmPropertyType.object,
          optional: true, linkTarget: 'Message'),
      SchemaProperty('emojiUnicode', RealmPropertyType.int),
    ]);
  }
}

class UserProfile extends _UserProfile
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  UserProfile(
    String id,
    String ownerId, {
    bool deactivated = false,
    String? name,
    String? email,
    int? age,
    int genderAsInt = 0,
    int? statusEmojiUnicode,
    bool typing = false,
    Set<Channel> channels = const {},
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<UserProfile>({
        'deactivated': false,
        'gender': 0,
        'typing': false,
      });
    }
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'owner_id', ownerId);
    RealmObjectBase.set(this, 'deactivated', deactivated);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'age', age);
    RealmObjectBase.set(this, 'gender', genderAsInt);
    RealmObjectBase.set(this, 'status_emoji', statusEmojiUnicode);
    RealmObjectBase.set(this, 'typing', typing);
    RealmObjectBase.set<RealmSet<Channel>>(
        this, 'channels', RealmSet<Channel>(channels));
  }

  UserProfile._();

  @override
  String get id => RealmObjectBase.get<String>(this, '_id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  bool get deactivated =>
      RealmObjectBase.get<bool>(this, 'deactivated') as bool;
  @override
  set deactivated(bool value) =>
      RealmObjectBase.set(this, 'deactivated', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get email => RealmObjectBase.get<String>(this, 'email') as String?;
  @override
  set email(String? value) => RealmObjectBase.set(this, 'email', value);

  @override
  int? get age => RealmObjectBase.get<int>(this, 'age') as int?;
  @override
  set age(int? value) => RealmObjectBase.set(this, 'age', value);

  @override
  int get genderAsInt => RealmObjectBase.get<int>(this, 'gender') as int;
  @override
  set genderAsInt(int value) => RealmObjectBase.set(this, 'gender', value);

  @override
  int? get statusEmojiUnicode =>
      RealmObjectBase.get<int>(this, 'status_emoji') as int?;
  @override
  set statusEmojiUnicode(int? value) =>
      RealmObjectBase.set(this, 'status_emoji', value);

  @override
  bool get typing => RealmObjectBase.get<bool>(this, 'typing') as bool;
  @override
  set typing(bool value) => RealmObjectBase.set(this, 'typing', value);

  @override
  RealmSet<Channel> get channels =>
      RealmObjectBase.get<Channel>(this, 'channels') as RealmSet<Channel>;
  @override
  set channels(covariant RealmSet<Channel> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<UserProfile>> get changes =>
      RealmObjectBase.getChanges<UserProfile>(this);

  @override
  UserProfile freeze() => RealmObjectBase.freezeObject<UserProfile>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(UserProfile._);
    return const SchemaObject(
        ObjectType.realmObject, UserProfile, 'UserProfile', [
      SchemaProperty('id', RealmPropertyType.string,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
      SchemaProperty('deactivated', RealmPropertyType.bool),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('email', RealmPropertyType.string, optional: true),
      SchemaProperty('age', RealmPropertyType.int, optional: true),
      SchemaProperty('genderAsInt', RealmPropertyType.int, mapTo: 'gender'),
      SchemaProperty('statusEmojiUnicode', RealmPropertyType.int,
          mapTo: 'status_emoji', optional: true),
      SchemaProperty('typing', RealmPropertyType.bool),
      SchemaProperty('channels', RealmPropertyType.object,
          linkTarget: 'Channel', collectionType: RealmCollectionType.set),
    ]);
  }
}
