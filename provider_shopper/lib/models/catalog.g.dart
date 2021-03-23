// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Item extends RealmObject {
  // ignore_for_file: unused_element, unused_local_variable
  Item._constructor() : super.constructor();
  Item();

  @RealmProperty(primaryKey: true)
  int get id => super['id'] as int;
  set id(int value) => super['id'] = value;

  @RealmProperty()
  String get name => super['name'] as String;
  set name(String value) => super['name'] = value;

  @RealmProperty(defaultValue: '42')
  int get price => super['price'] as int;
  set price(int value) => super['price'] = value;

  static dynamic getSchema() {
    const dynamic type = _Item;
    return RealmObject.getSchema('Item', [
      SchemaProperty('id', type: 'int', primaryKey: true),
      SchemaProperty('name', type: 'string'),
      SchemaProperty('price', type: 'int', defaultValue: '42'),
    ]);
  }
}
