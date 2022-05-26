import 'package:realm_dart/realm.dart';

import 'category.dart';

part 'now.g.dart';

@RealmModel()
class $Now {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late int time;
  $Category? category;
}