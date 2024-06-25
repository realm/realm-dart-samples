import 'package:realm/realm.dart';

part 'model.realm.dart';

@RealmModel()
class _Car {
  late String make;
  String? model;
}
