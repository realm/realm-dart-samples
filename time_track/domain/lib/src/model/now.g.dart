// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Now extends $Now with RealmEntity, RealmObjectBase, RealmObject {
  Now(
    ObjectId id,
    int microsecondsSinceEpoch, {
    Category? category,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'time', microsecondsSinceEpoch);
    RealmObjectBase.set(this, 'category', category);
  }

  Now._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  int get microsecondsSinceEpoch =>
      RealmObjectBase.get<int>(this, 'time') as int;
  @override
  set microsecondsSinceEpoch(int value) =>
      RealmObjectBase.set(this, 'time', value);

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
      SchemaProperty('_id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('time', RealmPropertyType.int, mapTo: 'time'),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
    ]);
  }
}
