import 'package:realm/realm.dart';
part 'model.g.dart';

@RealmModel()
class _Task {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String title;
  late bool isCompleted;
  late bool isImportant;
}
