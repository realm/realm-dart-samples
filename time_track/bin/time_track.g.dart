// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_track.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Category extends _Category with RealmObject {
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

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Category._);
    return const SchemaObject(Category, [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
    ]);
  }
}

class Now extends _Now with RealmObject {
  Now(
    int time, {
    Category? category,
  }) {
    this.time = time;
    this.category = category;
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

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Now._);
    return const SchemaObject(Now, [
      SchemaProperty('time', RealmPropertyType.int),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
    ]);
  }
}
