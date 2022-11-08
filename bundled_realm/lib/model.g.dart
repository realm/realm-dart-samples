// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Car extends _Car with RealmEntity, RealmObjectBase, RealmObject {
  Car(
    String make, {
    String? model,
  }) {
    RealmObjectBase.set(this, 'make', make);
    RealmObjectBase.set(this, 'model', model);
  }

  Car._();

  @override
  String get make => RealmObjectBase.get<String>(this, 'make') as String;
  @override
  set make(String value) => RealmObjectBase.set(this, 'make', value);

  @override
  String? get model => RealmObjectBase.get<String>(this, 'model') as String?;
  @override
  set model(String? value) => RealmObjectBase.set(this, 'model', value);

  @override
  Stream<RealmObjectChanges<Car>> get changes =>
      RealmObjectBase.getChanges<Car>(this);

  @override
  Car freeze() => RealmObjectBase.freezeObject<Car>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Car._);
    return const SchemaObject(ObjectType.realmObject, Car, 'Car', [
      SchemaProperty('make', RealmPropertyType.string),
      SchemaProperty('model', RealmPropertyType.string, optional: true),
    ]);
  }
}
