import 'package:realm_dart/realm.dart';

part 'category.g.dart';

@RealmModel()
class $Category {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late String name;
}