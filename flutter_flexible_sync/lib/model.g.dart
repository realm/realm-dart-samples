// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Task extends _Task with RealmEntity, RealmObject {
  Task(
    ObjectId id,
    String title,
    bool isCompleted,
    bool isImportant,
  ) {
    RealmObject.set(this, '_id', id);
    RealmObject.set(this, 'title', title);
    RealmObject.set(this, 'isCompleted', isCompleted);
    RealmObject.set(this, 'isImportant', isImportant);
  }

  Task._();

  @override
  ObjectId get id => RealmObject.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get title => RealmObject.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObject.set(this, 'title', value);

  @override
  bool get isCompleted => RealmObject.get<bool>(this, 'isCompleted') as bool;
  @override
  set isCompleted(bool value) => RealmObject.set(this, 'isCompleted', value);

  @override
  bool get isImportant => RealmObject.get<bool>(this, 'isImportant') as bool;
  @override
  set isImportant(bool value) => RealmObject.set(this, 'isImportant', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObject.getChanges<Task>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Task._);
    return const SchemaObject(Task, 'Task', [
      SchemaProperty('_id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('isCompleted', RealmPropertyType.bool),
      SchemaProperty('isImportant', RealmPropertyType.bool),
    ]);
  }
}
