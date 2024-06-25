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
    bool isCompleted,
    bool isImportant,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'isCompleted', isCompleted);
    RealmObjectBase.set(this, 'isImportant', isImportant);
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
  bool get isCompleted =>
      RealmObjectBase.get<bool>(this, 'isCompleted') as bool;
  @override
  set isCompleted(bool value) =>
      RealmObjectBase.set(this, 'isCompleted', value);

  @override
  bool get isImportant =>
      RealmObjectBase.get<bool>(this, 'isImportant') as bool;
  @override
  set isImportant(bool value) =>
      RealmObjectBase.set(this, 'isImportant', value);

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
      'isCompleted': isCompleted.toEJson(),
      'isImportant': isImportant.toEJson(),
    };
  }

  static EJsonValue _toEJson(Task value) => value.toEJson();
  static Task _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'title': EJsonValue title,
        'isCompleted': EJsonValue isCompleted,
        'isImportant': EJsonValue isImportant,
      } =>
        Task(
          fromEJson(id),
          fromEJson(title),
          fromEJson(isCompleted),
          fromEJson(isImportant),
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
      SchemaProperty('isCompleted', RealmPropertyType.bool),
      SchemaProperty('isImportant', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
