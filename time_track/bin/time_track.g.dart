// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_track.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Category extends _Category with RealmEntity, RealmObject {
  Category(
    String name,
  ) {
    RealmObject.set(this, 'name', name);
  }

  Category._();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Category>> get changes =>
      RealmObject.getChanges<Category>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Category._);
    return const SchemaObject(Category, 'Category', [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
    ]);
  }
}

class Now extends _Now with RealmEntity, RealmObject {
  Now(
    int time, {
    Category? category,
  }) {
    RealmObject.set(this, 'time', time);
    RealmObject.set(this, 'category', category);
  }

  Now._();

  @override
  int get time => RealmObject.get<int>(this, 'time') as int;
  @override
  set time(int value) => RealmObject.set(this, 'time', value);

  @override
  Category? get category =>
      RealmObject.get<Category>(this, 'category') as Category?;
  @override
  set category(covariant Category? value) =>
      RealmObject.set(this, 'category', value);

  @override
  Stream<RealmObjectChanges<Now>> get changes =>
      RealmObject.getChanges<Now>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Now._);
    return const SchemaObject(Now, 'Now', [
      SchemaProperty('time', RealmPropertyType.int),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
    ]);
  }
}
