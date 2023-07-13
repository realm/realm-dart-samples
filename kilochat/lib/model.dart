import 'package:realm/realm.dart';

part 'model.g.dart';

@RealmModel()
class _Channel {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('owner_id')
  late String ownerId; // matches user.id

  late _Channel? parent;
  late String name;
  late int count; // not used yet (await RealmInteger support)
}

@RealmModel()
class _Message {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('owner_id')
  late String ownerId; // matches owner.id
  _UserProfile? owner;

  @Indexed()
  @MapTo('channel_id')
  late ObjectId channelId; // matches channel.id

  _Channel? channel;

  @Indexed(RealmIndexType.fullText)
  late String text;

  @Backlink(#message)
  late Iterable<_Reaction> reactions;
}

@RealmModel()
class _Reaction {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('owner_id')
  late String ownerId; // matches owner.id
  late _UserProfile? owner;

  late _Message? message;

  late int emojiUnicode = 0;
  String get emoji => String.fromCharCode(emojiUnicode);
  set emoji(String value) => emojiUnicode = value.runes.first;
}

extension ReactionEx on Reaction {
  static Reaction create(UserProfile user, Message message, String emoji) {
    // Composite key
    final oid = ObjectId.fromValues(
      Object.hash(user.id, message.id, emoji), // rotate for more entropy
      Object.hash(message.id, emoji, user.id),
      Object.hash(emoji, user.id, message.id),
    );
    return Reaction(
      oid,
      user.id,
      owner: user,
      message: message,
      emojiUnicode: emoji.runes.first,
    );
  }
}

enum Gender {
  unknown,
  male,
  female,
  other;

  factory Gender.parse(String input) => tryParse(input)!;

  static final _nameMap = values.asNameMap();
  static Gender? tryParse(String input) => _nameMap[input];
}

@RealmModel()
class _UserProfile {
  @PrimaryKey()
  @MapTo('_id')
  late String id; // matches user.id

  @MapTo('owner_id')
  late String ownerId; // matches user.id

  var deactivated = false;

  String? name;

  String? email;

  int? age;

  @MapTo('gender')
  int genderAsInt = 0; // = Gender.unknown.index; // <-- not a const expression
  Gender get gender => Gender.values[genderAsInt];
  set gender(Gender value) => genderAsInt = value.index;

  @MapTo('status_emoji')
  int? statusEmojiUnicode;
  String? get statusEmoji {
    final s = statusEmojiUnicode;
    if (s == null) return null;
    return String.fromCharCode(s);
  }

  set statusEmoji(String? value) => statusEmojiUnicode = value?.runes.first;

  var typing = false;

  late Set<_Channel> channels;

  late Set<_UserProfile> bodies;
}
