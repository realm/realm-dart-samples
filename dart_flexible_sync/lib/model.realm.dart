// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Task extends _Task with RealmEntity, RealmObjectBase, RealmObject {
  Task(
    ObjectId id,
    String title,
    String status,
    int progressMinutes,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'progressMinutes', progressMinutes);
  }

  Task._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  int get progressMinutes =>
      RealmObjectBase.get<int>(this, 'progressMinutes') as int;
  @override
  set progressMinutes(int value) =>
      RealmObjectBase.set(this, 'progressMinutes', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObjectBase.getChanges<Task>(this);

  @override
  Stream<RealmObjectChanges<Task>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Task>(this, keyPaths);

  @override
  Task freeze() => RealmObjectBase.freezeObject<Task>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'title': title.toEJson(),
      'status': status.toEJson(),
      'progressMinutes': progressMinutes.toEJson(),
    };
  }

  static EJsonValue _toEJson(Task value) => value.toEJson();
  static Task _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'title': EJsonValue title,
        'status': EJsonValue status,
        'progressMinutes': EJsonValue progressMinutes,
      } =>
        Task(
          fromEJson(id),
          fromEJson(title),
          fromEJson(status),
          fromEJson(progressMinutes),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Task._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Task, 'Task', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('progressMinutes', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
