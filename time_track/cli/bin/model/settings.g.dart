// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Setting extends _Setting with RealmEntity, RealmObject {
  Setting(
    String key,
    String value,
  ) {
    RealmObject.set(this, 'key', key);
    RealmObject.set(this, 'value', value);
  }

  Setting._();

  @override
  String get key => RealmObject.get<String>(this, 'key') as String;
  @override
  set key(String value) => throw RealmUnsupportedSetError();

  @override
  String get value => RealmObject.get<String>(this, 'value') as String;
  @override
  set value(String value) => RealmObject.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<Setting>> get changes =>
      RealmObject.getChanges<Setting>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Setting._);
    return const SchemaObject(Setting, 'Setting', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('value', RealmPropertyType.string),
    ]);
  }
}
