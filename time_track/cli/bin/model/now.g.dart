// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Now extends $Now with RealmEntity, RealmObject {
  Now(
    ObjectId id,
    int time, {
    Category? category,
  }) {
    RealmObject.set(this, '_id', id);
    RealmObject.set(this, 'time', time);
    RealmObject.set(this, 'category', category);
  }

  Now._();

  @override
  ObjectId get id => RealmObject.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

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
      SchemaProperty('_id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('time', RealmPropertyType.int),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
    ]);
  }
}
