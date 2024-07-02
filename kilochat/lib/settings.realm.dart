// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Workspace extends _Workspace
    with RealmEntity, RealmObjectBase, RealmObject {
  Workspace(
    String appId,
    String name, {
    ObjectId? currentChannelId,
  }) {
    RealmObjectBase.set(this, 'appId', appId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'currentChannelId', currentChannelId);
  }

  Workspace._();

  @override
  String get appId => RealmObjectBase.get<String>(this, 'appId') as String;
  @override
  set appId(String value) => RealmObjectBase.set(this, 'appId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  ObjectId? get currentChannelId =>
      RealmObjectBase.get<ObjectId>(this, 'currentChannelId') as ObjectId?;
  @override
  set currentChannelId(ObjectId? value) =>
      RealmObjectBase.set(this, 'currentChannelId', value);

  @override
  Stream<RealmObjectChanges<Workspace>> get changes =>
      RealmObjectBase.getChanges<Workspace>(this);

  @override
  Stream<RealmObjectChanges<Workspace>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Workspace>(this, keyPaths);

  @override
  Workspace freeze() => RealmObjectBase.freezeObject<Workspace>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'appId': appId.toEJson(),
      'name': name.toEJson(),
      'currentChannelId': currentChannelId.toEJson(),
    };
  }

  static EJsonValue _toEJson(Workspace value) => value.toEJson();
  static Workspace _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'appId': EJsonValue appId,
        'name': EJsonValue name,
        'currentChannelId': EJsonValue currentChannelId,
      } =>
        Workspace(
          fromEJson(appId),
          fromEJson(name),
          currentChannelId: fromEJson(currentChannelId),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Workspace._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Workspace, 'Workspace', [
      SchemaProperty('appId', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('currentChannelId', RealmPropertyType.objectid,
          optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Settings extends _Settings
    with RealmEntity, RealmObjectBase, RealmObject {
  Settings({
    Workspace? workspace,
  }) {
    RealmObjectBase.set(this, 'workspace', workspace);
  }

  Settings._();

  @override
  Workspace? get workspace =>
      RealmObjectBase.get<Workspace>(this, 'workspace') as Workspace?;
  @override
  set workspace(covariant Workspace? value) =>
      RealmObjectBase.set(this, 'workspace', value);

  @override
  Stream<RealmObjectChanges<Settings>> get changes =>
      RealmObjectBase.getChanges<Settings>(this);

  @override
  Stream<RealmObjectChanges<Settings>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Settings>(this, keyPaths);

  @override
  Settings freeze() => RealmObjectBase.freezeObject<Settings>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'workspace': workspace.toEJson(),
    };
  }

  static EJsonValue _toEJson(Settings value) => value.toEJson();
  static Settings _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'workspace': EJsonValue workspace,
      } =>
        Settings(
          workspace: fromEJson(workspace),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Settings._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Settings, 'Settings', [
      SchemaProperty('workspace', RealmPropertyType.object,
          optional: true, linkTarget: 'Workspace'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
