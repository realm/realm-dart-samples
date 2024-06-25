// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_track.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Category extends _Category
    with RealmEntity, RealmObjectBase, RealmObject {
  Category(
    String name,
  ) {
    RealmObjectBase.set(this, 'name', name);
  }

  Category._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<Category>> get changes =>
      RealmObjectBase.getChanges<Category>(this);

  @override
  Stream<RealmObjectChanges<Category>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Category>(this, keyPaths);

  @override
  Category freeze() => RealmObjectBase.freezeObject<Category>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'name': name.toEJson(),
    };
  }

  static EJsonValue _toEJson(Category value) => value.toEJson();
  static Category _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'name': EJsonValue name,
      } =>
        Category(
          fromEJson(name),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Category._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Category, 'Category', [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Now extends _Now with RealmEntity, RealmObjectBase, RealmObject {
  Now(
    int time, {
    Category? category,
  }) {
    RealmObjectBase.set(this, 'time', time);
    RealmObjectBase.set(this, 'category', category);
  }

  Now._();

  @override
  int get time => RealmObjectBase.get<int>(this, 'time') as int;
  @override
  set time(int value) => RealmObjectBase.set(this, 'time', value);

  @override
  Category? get category =>
      RealmObjectBase.get<Category>(this, 'category') as Category?;
  @override
  set category(covariant Category? value) =>
      RealmObjectBase.set(this, 'category', value);

  @override
  Stream<RealmObjectChanges<Now>> get changes =>
      RealmObjectBase.getChanges<Now>(this);

  @override
  Stream<RealmObjectChanges<Now>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Now>(this, keyPaths);

  @override
  Now freeze() => RealmObjectBase.freezeObject<Now>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'time': time.toEJson(),
      'category': category.toEJson(),
    };
  }

  static EJsonValue _toEJson(Now value) => value.toEJson();
  static Now _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'time': EJsonValue time,
        'category': EJsonValue category,
      } =>
        Now(
          fromEJson(time),
          category: fromEJson(category),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Now._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Now, 'Now', [
      SchemaProperty('time', RealmPropertyType.int,
          indexType: RealmIndexType.regular),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
