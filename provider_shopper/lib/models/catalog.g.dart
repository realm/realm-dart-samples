// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'catalog.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Item extends _Item with RealmObject {
  static var _defaultsSet = false;

  Item(
    int id,
    String name, {
    int price = 42,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<Item>({
        'price': 42,
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
  set id(int value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  int get price => RealmObject.get<int>(this, 'price') as int;

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Item._);
    return const SchemaObject(Item, [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.int),
    ]);
  }
}
