import 'package:realm/realm.dart';
part 'model.g.dart';

@RealmModel()
class _Car {
  late String make;
  String? model;
}
