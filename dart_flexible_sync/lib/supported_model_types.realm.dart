// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_model_types.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class AllPrimitiveOptional extends _AllPrimitiveOptional
    with RealmEntity, RealmObjectBase, RealmObject {
  AllPrimitiveOptional({
    String? stringProp,
    bool? boolProp,
    DateTime? dateProp,
    double? doubleProp,
    ObjectId? objectIdProp,
    Uuid? uuidProp,
    int? intProp,
  }) {
    RealmObjectBase.set(this, 'stringProp', stringProp);
    RealmObjectBase.set(this, 'boolProp', boolProp);
    RealmObjectBase.set(this, 'dateProp', dateProp);
    RealmObjectBase.set(this, 'doubleProp', doubleProp);
    RealmObjectBase.set(this, 'objectIdProp', objectIdProp);
    RealmObjectBase.set(this, 'uuidProp', uuidProp);
    RealmObjectBase.set(this, 'intProp', intProp);
  }

  AllPrimitiveOptional._();

  @override
  String? get stringProp =>
      RealmObjectBase.get<String>(this, 'stringProp') as String?;
  @override
  set stringProp(String? value) =>
      RealmObjectBase.set(this, 'stringProp', value);

  @override
  bool? get boolProp => RealmObjectBase.get<bool>(this, 'boolProp') as bool?;
  @override
  set boolProp(bool? value) => RealmObjectBase.set(this, 'boolProp', value);

  @override
  DateTime? get dateProp =>
      RealmObjectBase.get<DateTime>(this, 'dateProp') as DateTime?;
  @override
  set dateProp(DateTime? value) => RealmObjectBase.set(this, 'dateProp', value);

  @override
  double? get doubleProp =>
      RealmObjectBase.get<double>(this, 'doubleProp') as double?;
  @override
  set doubleProp(double? value) =>
      RealmObjectBase.set(this, 'doubleProp', value);

  @override
  ObjectId? get objectIdProp =>
      RealmObjectBase.get<ObjectId>(this, 'objectIdProp') as ObjectId?;
  @override
  set objectIdProp(ObjectId? value) =>
      RealmObjectBase.set(this, 'objectIdProp', value);

  @override
  Uuid? get uuidProp => RealmObjectBase.get<Uuid>(this, 'uuidProp') as Uuid?;
  @override
  set uuidProp(Uuid? value) => RealmObjectBase.set(this, 'uuidProp', value);

  @override
  int? get intProp => RealmObjectBase.get<int>(this, 'intProp') as int?;
  @override
  set intProp(int? value) => RealmObjectBase.set(this, 'intProp', value);

  @override
  Stream<RealmObjectChanges<AllPrimitiveOptional>> get changes =>
      RealmObjectBase.getChanges<AllPrimitiveOptional>(this);

  @override
  Stream<RealmObjectChanges<AllPrimitiveOptional>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AllPrimitiveOptional>(this, keyPaths);

  @override
  AllPrimitiveOptional freeze() =>
      RealmObjectBase.freezeObject<AllPrimitiveOptional>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'stringProp': stringProp.toEJson(),
      'boolProp': boolProp.toEJson(),
      'dateProp': dateProp.toEJson(),
      'doubleProp': doubleProp.toEJson(),
      'objectIdProp': objectIdProp.toEJson(),
      'uuidProp': uuidProp.toEJson(),
      'intProp': intProp.toEJson(),
    };
  }

  static EJsonValue _toEJson(AllPrimitiveOptional value) => value.toEJson();
  static AllPrimitiveOptional _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'stringProp': EJsonValue stringProp,
        'boolProp': EJsonValue boolProp,
        'dateProp': EJsonValue dateProp,
        'doubleProp': EJsonValue doubleProp,
        'objectIdProp': EJsonValue objectIdProp,
        'uuidProp': EJsonValue uuidProp,
        'intProp': EJsonValue intProp,
      } =>
        AllPrimitiveOptional(
          stringProp: fromEJson(stringProp),
          boolProp: fromEJson(boolProp),
          dateProp: fromEJson(dateProp),
          doubleProp: fromEJson(doubleProp),
          objectIdProp: fromEJson(objectIdProp),
          uuidProp: fromEJson(uuidProp),
          intProp: fromEJson(intProp),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AllPrimitiveOptional._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, AllPrimitiveOptional, 'AllPrimitiveOptional', [
      SchemaProperty('stringProp', RealmPropertyType.string, optional: true),
      SchemaProperty('boolProp', RealmPropertyType.bool, optional: true),
      SchemaProperty('dateProp', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('doubleProp', RealmPropertyType.double, optional: true),
      SchemaProperty('objectIdProp', RealmPropertyType.objectid,
          optional: true),
      SchemaProperty('uuidProp', RealmPropertyType.uuid, optional: true),
      SchemaProperty('intProp', RealmPropertyType.int, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class AllPrimitiveRequired extends _AllPrimitiveRequired
    with RealmEntity, RealmObjectBase, RealmObject {
  AllPrimitiveRequired(
    ObjectId id,
    String stringProp,
    bool boolProp,
    DateTime dateProp,
    double doubleProp,
    ObjectId objectIdProp,
    Uuid uuidProp,
    int intProp,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'stringProp', stringProp);
    RealmObjectBase.set(this, 'boolProp', boolProp);
    RealmObjectBase.set(this, 'dateProp', dateProp);
    RealmObjectBase.set(this, 'doubleProp', doubleProp);
    RealmObjectBase.set(this, 'objectIdProp', objectIdProp);
    RealmObjectBase.set(this, 'uuidProp', uuidProp);
    RealmObjectBase.set(this, 'intProp', intProp);
  }

  AllPrimitiveRequired._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get stringProp =>
      RealmObjectBase.get<String>(this, 'stringProp') as String;
  @override
  set stringProp(String value) =>
      RealmObjectBase.set(this, 'stringProp', value);

  @override
  bool get boolProp => RealmObjectBase.get<bool>(this, 'boolProp') as bool;
  @override
  set boolProp(bool value) => RealmObjectBase.set(this, 'boolProp', value);

  @override
  DateTime get dateProp =>
      RealmObjectBase.get<DateTime>(this, 'dateProp') as DateTime;
  @override
  set dateProp(DateTime value) => RealmObjectBase.set(this, 'dateProp', value);

  @override
  double get doubleProp =>
      RealmObjectBase.get<double>(this, 'doubleProp') as double;
  @override
  set doubleProp(double value) =>
      RealmObjectBase.set(this, 'doubleProp', value);

  @override
  ObjectId get objectIdProp =>
      RealmObjectBase.get<ObjectId>(this, 'objectIdProp') as ObjectId;
  @override
  set objectIdProp(ObjectId value) =>
      RealmObjectBase.set(this, 'objectIdProp', value);

  @override
  Uuid get uuidProp => RealmObjectBase.get<Uuid>(this, 'uuidProp') as Uuid;
  @override
  set uuidProp(Uuid value) => RealmObjectBase.set(this, 'uuidProp', value);

  @override
  int get intProp => RealmObjectBase.get<int>(this, 'intProp') as int;
  @override
  set intProp(int value) => RealmObjectBase.set(this, 'intProp', value);

  @override
  Stream<RealmObjectChanges<AllPrimitiveRequired>> get changes =>
      RealmObjectBase.getChanges<AllPrimitiveRequired>(this);

  @override
  Stream<RealmObjectChanges<AllPrimitiveRequired>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AllPrimitiveRequired>(this, keyPaths);

  @override
  AllPrimitiveRequired freeze() =>
      RealmObjectBase.freezeObject<AllPrimitiveRequired>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'stringProp': stringProp.toEJson(),
      'boolProp': boolProp.toEJson(),
      'dateProp': dateProp.toEJson(),
      'doubleProp': doubleProp.toEJson(),
      'objectIdProp': objectIdProp.toEJson(),
      'uuidProp': uuidProp.toEJson(),
      'intProp': intProp.toEJson(),
    };
  }

  static EJsonValue _toEJson(AllPrimitiveRequired value) => value.toEJson();
  static AllPrimitiveRequired _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'stringProp': EJsonValue stringProp,
        'boolProp': EJsonValue boolProp,
        'dateProp': EJsonValue dateProp,
        'doubleProp': EJsonValue doubleProp,
        'objectIdProp': EJsonValue objectIdProp,
        'uuidProp': EJsonValue uuidProp,
        'intProp': EJsonValue intProp,
      } =>
        AllPrimitiveRequired(
          fromEJson(id),
          fromEJson(stringProp),
          fromEJson(boolProp),
          fromEJson(dateProp),
          fromEJson(doubleProp),
          fromEJson(objectIdProp),
          fromEJson(uuidProp),
          fromEJson(intProp),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AllPrimitiveRequired._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, AllPrimitiveRequired, 'AllPrimitiveRequired', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('stringProp', RealmPropertyType.string),
      SchemaProperty('boolProp', RealmPropertyType.bool),
      SchemaProperty('dateProp', RealmPropertyType.timestamp),
      SchemaProperty('doubleProp', RealmPropertyType.double),
      SchemaProperty('objectIdProp', RealmPropertyType.objectid),
      SchemaProperty('uuidProp', RealmPropertyType.uuid),
      SchemaProperty('intProp', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class AllPrimitiveLists extends _AllPrimitiveLists
    with RealmEntity, RealmObjectBase, RealmObject {
  AllPrimitiveLists({
    Iterable<String> strings = const [],
    Iterable<bool> bools = const [],
    Iterable<DateTime> dates = const [],
    Iterable<double> doubles = const [],
    Iterable<ObjectId> objectIds = const [],
    Iterable<Uuid> uuids = const [],
    Iterable<int> ints = const [],
  }) {
    RealmObjectBase.set<RealmList<String>>(
        this, 'strings', RealmList<String>(strings));
    RealmObjectBase.set<RealmList<bool>>(this, 'bools', RealmList<bool>(bools));
    RealmObjectBase.set<RealmList<DateTime>>(
        this, 'dates', RealmList<DateTime>(dates));
    RealmObjectBase.set<RealmList<double>>(
        this, 'doubles', RealmList<double>(doubles));
    RealmObjectBase.set<RealmList<ObjectId>>(
        this, 'objectIds', RealmList<ObjectId>(objectIds));
    RealmObjectBase.set<RealmList<Uuid>>(this, 'uuids', RealmList<Uuid>(uuids));
    RealmObjectBase.set<RealmList<int>>(this, 'ints', RealmList<int>(ints));
  }

  AllPrimitiveLists._();

  @override
  RealmList<String> get strings =>
      RealmObjectBase.get<String>(this, 'strings') as RealmList<String>;
  @override
  set strings(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<bool> get bools =>
      RealmObjectBase.get<bool>(this, 'bools') as RealmList<bool>;
  @override
  set bools(covariant RealmList<bool> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<DateTime> get dates =>
      RealmObjectBase.get<DateTime>(this, 'dates') as RealmList<DateTime>;
  @override
  set dates(covariant RealmList<DateTime> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<double> get doubles =>
      RealmObjectBase.get<double>(this, 'doubles') as RealmList<double>;
  @override
  set doubles(covariant RealmList<double> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ObjectId> get objectIds =>
      RealmObjectBase.get<ObjectId>(this, 'objectIds') as RealmList<ObjectId>;
  @override
  set objectIds(covariant RealmList<ObjectId> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<Uuid> get uuids =>
      RealmObjectBase.get<Uuid>(this, 'uuids') as RealmList<Uuid>;
  @override
  set uuids(covariant RealmList<Uuid> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<int> get ints =>
      RealmObjectBase.get<int>(this, 'ints') as RealmList<int>;
  @override
  set ints(covariant RealmList<int> value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<AllPrimitiveLists>> get changes =>
      RealmObjectBase.getChanges<AllPrimitiveLists>(this);

  @override
  Stream<RealmObjectChanges<AllPrimitiveLists>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AllPrimitiveLists>(this, keyPaths);

  @override
  AllPrimitiveLists freeze() =>
      RealmObjectBase.freezeObject<AllPrimitiveLists>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'strings': strings.toEJson(),
      'bools': bools.toEJson(),
      'dates': dates.toEJson(),
      'doubles': doubles.toEJson(),
      'objectIds': objectIds.toEJson(),
      'uuids': uuids.toEJson(),
      'ints': ints.toEJson(),
    };
  }

  static EJsonValue _toEJson(AllPrimitiveLists value) => value.toEJson();
  static AllPrimitiveLists _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'strings': EJsonValue strings,
        'bools': EJsonValue bools,
        'dates': EJsonValue dates,
        'doubles': EJsonValue doubles,
        'objectIds': EJsonValue objectIds,
        'uuids': EJsonValue uuids,
        'ints': EJsonValue ints,
      } =>
        AllPrimitiveLists(
          strings: fromEJson(strings),
          bools: fromEJson(bools),
          dates: fromEJson(dates),
          doubles: fromEJson(doubles),
          objectIds: fromEJson(objectIds),
          uuids: fromEJson(uuids),
          ints: fromEJson(ints),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AllPrimitiveLists._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, AllPrimitiveLists, 'AllPrimitiveLists', [
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
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
