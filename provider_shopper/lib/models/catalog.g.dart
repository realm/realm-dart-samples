// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Item extends _Item with RealmEntity, RealmObject {
  static var _defaultsSet = false;

  Item(
    int id,
    String name, {
    int price = 0,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<Item>({
        'price': 0,
      });
    }
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'price', price);
  }

  Item._();

  @override
  int get id => RealmObject.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObject.set(this, 'id', value);

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  int get price => RealmObject.get<int>(this, 'price') as int;
  @override
  set price(int value) => RealmObject.set(this, 'price', value);

  @override
  Stream<RealmObjectChanges<Item>> get changes =>
      RealmObject.getChanges<Item>(this);

  @override
  Item freeze() => RealmObject.freezeObject<Item>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Item._);
    return const SchemaObject(Item, 'Item', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.int),
    ]);
  }
}
