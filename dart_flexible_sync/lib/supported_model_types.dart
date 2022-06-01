import 'package:realm_dart/realm.dart';
part 'supported_model_types.g.dart';

@RealmModel()
class _AllPrimitiveOptional {
  late String? stringProp;
  late bool? boolProp;
  late DateTime? dateProp;
  late double? doubleProp;
  late ObjectId? objectIdProp;
  late Uuid? uuidProp;
  late int? intProp;
}

@RealmModel()
class _AllPrimitiveRequired {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String stringProp;
  late bool boolProp;
  late DateTime dateProp;
  late double doubleProp;
  late ObjectId objectIdProp;
  late Uuid uuidProp;
  late int intProp;
}

@RealmModel()
class _AllPrimitiveLists {
  late List<String> strings;
  late List<bool> bools;
  late List<DateTime> dates;
  late List<double> doubles;
  late List<ObjectId> objectIds;
  late List<Uuid> uuids;
  late List<int> ints;
}

