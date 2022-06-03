import 'package:realm_dart/realm.dart';
part 'model.g.dart';

@RealmModel()
class _Task {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String title;
  late String status;
  late int progressMinutes;
}
