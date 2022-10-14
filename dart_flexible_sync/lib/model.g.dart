// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Task extends _Task with RealmEntity, RealmObject {
  Task(
    ObjectId id,
    String title,
    String status,
    int progressMinutes,
  ) {
    RealmObject.set(this, '_id', id);
    RealmObject.set(this, 'title', title);
    RealmObject.set(this, 'status', status);
    RealmObject.set(this, 'progressMinutes', progressMinutes);
  }

  Task._();

  @override
  ObjectId get id => RealmObject.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObject.set(this, '_id', value);

  @override
  String get title => RealmObject.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObject.set(this, 'title', value);

  @override
  String get status => RealmObject.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObject.set(this, 'status', value);

  @override
  int get progressMinutes =>
      RealmObject.get<int>(this, 'progressMinutes') as int;
  @override
  set progressMinutes(int value) =>
      RealmObject.set(this, 'progressMinutes', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObject.getChanges<Task>(this);

  @override
  Task freeze() => RealmObject.freezeObject<Task>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Task._);
    return const SchemaObject(Task, 'Task', [
      SchemaProperty('_id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('progressMinutes', RealmPropertyType.int),
    ]);
  }
}
