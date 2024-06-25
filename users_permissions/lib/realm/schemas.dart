import 'package:realm/realm.dart';

part 'schemas.realm.dart';

@RealmModel()
class _Item {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  bool isComplete = false;
  late String summary;
  @MapTo('owner_id')
  late String ownerId;
}

@RealmModel()
class _Role {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  bool isAdmin = false;
  @MapTo('owner_id')
  late String ownerId;
}
