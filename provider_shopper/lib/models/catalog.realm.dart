// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Item extends _Item with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Item(
    int id,
    String name, {
    int price = 0,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Item>({
        'price': 0,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'price', price);
  }

  Item._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get price => RealmObjectBase.get<int>(this, 'price') as int;
  @override
  set price(int value) => RealmObjectBase.set(this, 'price', value);

  @override
  Stream<RealmObjectChanges<Item>> get changes =>
      RealmObjectBase.getChanges<Item>(this);

  @override
  Stream<RealmObjectChanges<Item>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Item>(this, keyPaths);

  @override
  Item freeze() => RealmObjectBase.freezeObject<Item>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'price': price.toEJson(),
    };
  }

  static EJsonValue _toEJson(Item value) => value.toEJson();
  static Item _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'price': EJsonValue price,
      } =>
        Item(
          fromEJson(id),
          fromEJson(name),
          price: fromEJson(price),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Item._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Item, 'Item', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
