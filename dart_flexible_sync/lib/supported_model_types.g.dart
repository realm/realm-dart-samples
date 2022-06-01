// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_model_types.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class AllPrimitiveOptional extends _AllPrimitiveOptional
    with RealmEntity, RealmObject {
  AllPrimitiveOptional({
    String? stringProp,
    bool? boolProp,
    DateTime? dateProp,
    double? doubleProp,
    ObjectId? objectIdProp,
    Uuid? uuidProp,
    int? intProp,
  }) {
    RealmObject.set(this, 'stringProp', stringProp);
    RealmObject.set(this, 'boolProp', boolProp);
    RealmObject.set(this, 'dateProp', dateProp);
    RealmObject.set(this, 'doubleProp', doubleProp);
    RealmObject.set(this, 'objectIdProp', objectIdProp);
    RealmObject.set(this, 'uuidProp', uuidProp);
    RealmObject.set(this, 'intProp', intProp);
  }

  AllPrimitiveOptional._();

  @override
  String? get stringProp =>
      RealmObject.get<String>(this, 'stringProp') as String?;
  @override
  set stringProp(String? value) => RealmObject.set(this, 'stringProp', value);

  @override
  bool? get boolProp => RealmObject.get<bool>(this, 'boolProp') as bool?;
  @override
  set boolProp(bool? value) => RealmObject.set(this, 'boolProp', value);

  @override
  DateTime? get dateProp =>
      RealmObject.get<DateTime>(this, 'dateProp') as DateTime?;
  @override
  set dateProp(DateTime? value) => RealmObject.set(this, 'dateProp', value);

  @override
  double? get doubleProp =>
      RealmObject.get<double>(this, 'doubleProp') as double?;
  @override
  set doubleProp(double? value) => RealmObject.set(this, 'doubleProp', value);

  @override
  ObjectId? get objectIdProp =>
      RealmObject.get<ObjectId>(this, 'objectIdProp') as ObjectId?;
  @override
  set objectIdProp(ObjectId? value) =>
      RealmObject.set(this, 'objectIdProp', value);

  @override
  Uuid? get uuidProp => RealmObject.get<Uuid>(this, 'uuidProp') as Uuid?;
  @override
  set uuidProp(Uuid? value) => RealmObject.set(this, 'uuidProp', value);

  @override
  int? get intProp => RealmObject.get<int>(this, 'intProp') as int?;
  @override
  set intProp(int? value) => RealmObject.set(this, 'intProp', value);

  @override
  Stream<RealmObjectChanges<AllPrimitiveOptional>> get changes =>
      RealmObject.getChanges<AllPrimitiveOptional>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(AllPrimitiveOptional._);
    return const SchemaObject(AllPrimitiveOptional, 'AllPrimitiveOptional', [
      SchemaProperty('stringProp', RealmPropertyType.string, optional: true),
      SchemaProperty('boolProp', RealmPropertyType.bool, optional: true),
      SchemaProperty('dateProp', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('doubleProp', RealmPropertyType.double, optional: true),
      SchemaProperty('objectIdProp', RealmPropertyType.objectid,
          optional: true),
      SchemaProperty('uuidProp', RealmPropertyType.uuid, optional: true),
      SchemaProperty('intProp', RealmPropertyType.int, optional: true),
    ]);
  }
}

class AllPrimitiveRequired extends _AllPrimitiveRequired
    with RealmEntity, RealmObject {
  AllPrimitiveRequired(
    String stringProp,
    bool boolProp,
    DateTime dateProp,
    double doubleProp,
    ObjectId objectIdProp,
    Uuid uuidProp,
    int intProp,
  ) {
    RealmObject.set(this, 'stringProp', stringProp);
    RealmObject.set(this, 'boolProp', boolProp);
    RealmObject.set(this, 'dateProp', dateProp);
    RealmObject.set(this, 'doubleProp', doubleProp);
    RealmObject.set(this, 'objectIdProp', objectIdProp);
    RealmObject.set(this, 'uuidProp', uuidProp);
    RealmObject.set(this, 'intProp', intProp);
  }

  AllPrimitiveRequired._();

  @override
  String get stringProp =>
      RealmObject.get<String>(this, 'stringProp') as String;
  @override
  set stringProp(String value) => RealmObject.set(this, 'stringProp', value);

  @override
  bool get boolProp => RealmObject.get<bool>(this, 'boolProp') as bool;
  @override
  set boolProp(bool value) => RealmObject.set(this, 'boolProp', value);

  @override
  DateTime get dateProp =>
      RealmObject.get<DateTime>(this, 'dateProp') as DateTime;
  @override
  set dateProp(DateTime value) => RealmObject.set(this, 'dateProp', value);

  @override
  double get doubleProp =>
      RealmObject.get<double>(this, 'doubleProp') as double;
  @override
  set doubleProp(double value) => RealmObject.set(this, 'doubleProp', value);

  @override
  ObjectId get objectIdProp =>
      RealmObject.get<ObjectId>(this, 'objectIdProp') as ObjectId;
  @override
  set objectIdProp(ObjectId value) =>
      RealmObject.set(this, 'objectIdProp', value);

  @override
  Uuid get uuidProp => RealmObject.get<Uuid>(this, 'uuidProp') as Uuid;
  @override
  set uuidProp(Uuid value) => RealmObject.set(this, 'uuidProp', value);

  @override
  int get intProp => RealmObject.get<int>(this, 'intProp') as int;
  @override
  set intProp(int value) => RealmObject.set(this, 'intProp', value);

  @override
  Stream<RealmObjectChanges<AllPrimitiveRequired>> get changes =>
      RealmObject.getChanges<AllPrimitiveRequired>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(AllPrimitiveRequired._);
    return const SchemaObject(AllPrimitiveRequired, 'AllPrimitiveRequired', [
      SchemaProperty('stringProp', RealmPropertyType.string),
      SchemaProperty('boolProp', RealmPropertyType.bool),
      SchemaProperty('dateProp', RealmPropertyType.timestamp),
      SchemaProperty('doubleProp', RealmPropertyType.double),
      SchemaProperty('objectIdProp', RealmPropertyType.objectid),
      SchemaProperty('uuidProp', RealmPropertyType.uuid),
      SchemaProperty('intProp', RealmPropertyType.int),
    ]);
  }
}

class AllPrimitiveLists extends _AllPrimitiveLists
    with RealmEntity, RealmObject {
  AllPrimitiveLists({
    Iterable<String> strings = const [],
    Iterable<bool> bools = const [],
    Iterable<DateTime> dates = const [],
    Iterable<double> doubles = const [],
    Iterable<ObjectId> objectIds = const [],
    Iterable<Uuid> uuids = const [],
    Iterable<int> ints = const [],
  }) {
    RealmObject.set<RealmList<String>>(
        this, 'strings', RealmList<String>(strings));
    RealmObject.set<RealmList<bool>>(this, 'bools', RealmList<bool>(bools));
    RealmObject.set<RealmList<DateTime>>(
        this, 'dates', RealmList<DateTime>(dates));
    RealmObject.set<RealmList<double>>(
        this, 'doubles', RealmList<double>(doubles));
    RealmObject.set<RealmList<ObjectId>>(
        this, 'objectIds', RealmList<ObjectId>(objectIds));
    RealmObject.set<RealmList<Uuid>>(this, 'uuids', RealmList<Uuid>(uuids));
    RealmObject.set<RealmList<int>>(this, 'ints', RealmList<int>(ints));
  }

  AllPrimitiveLists._();

  @override
  RealmList<String> get strings =>
      RealmObject.get<String>(this, 'strings') as RealmList<String>;
  @override
  set strings(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<bool> get bools =>
      RealmObject.get<bool>(this, 'bools') as RealmList<bool>;
  @override
  set bools(covariant RealmList<bool> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<DateTime> get dates =>
      RealmObject.get<DateTime>(this, 'dates') as RealmList<DateTime>;
  @override
  set dates(covariant RealmList<DateTime> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<double> get doubles =>
      RealmObject.get<double>(this, 'doubles') as RealmList<double>;
  @override
  set doubles(covariant RealmList<double> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ObjectId> get objectIds =>
      RealmObject.get<ObjectId>(this, 'objectIds') as RealmList<ObjectId>;
  @override
  set objectIds(covariant RealmList<ObjectId> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<Uuid> get uuids =>
      RealmObject.get<Uuid>(this, 'uuids') as RealmList<Uuid>;
  @override
  set uuids(covariant RealmList<Uuid> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<int> get ints =>
      RealmObject.get<int>(this, 'ints') as RealmList<int>;
  @override
  set ints(covariant RealmList<int> value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<AllPrimitiveLists>> get changes =>
      RealmObject.getChanges<AllPrimitiveLists>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(AllPrimitiveLists._);
    return const SchemaObject(AllPrimitiveLists, 'AllPrimitiveLists', [
      SchemaProperty('strings', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('bools', RealmPropertyType.bool,
          collectionType: RealmCollectionType.list),
      SchemaProperty('dates', RealmPropertyType.timestamp,
          collectionType: RealmCollectionType.list),
      SchemaProperty('doubles', RealmPropertyType.double,
          collectionType: RealmCollectionType.list),
      SchemaProperty('objectIds', RealmPropertyType.objectid,
          collectionType: RealmCollectionType.list),
      SchemaProperty('uuids', RealmPropertyType.uuid,
          collectionType: RealmCollectionType.list),
      SchemaProperty('ints', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
