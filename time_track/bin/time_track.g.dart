// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_track.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

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
  Category freeze() => RealmObjectBase.freezeObject<Category>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Category._);
    return const SchemaObject(ObjectType.realmObject, Category, 'Category', [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
    ]);
  }
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
  Now freeze() => RealmObjectBase.freezeObject<Now>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Now._);
    return const SchemaObject(ObjectType.realmObject, Now, 'Now', [
      SchemaProperty('time', RealmPropertyType.int),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
    ]);
  }
}
