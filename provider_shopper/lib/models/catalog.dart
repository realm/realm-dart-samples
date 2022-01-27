// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';

// Realm: Import realm
import 'package:realm/realm.dart';

// Realm: Declare a part file
part 'catalog.g.dart';

// Realm: Creating a Realm object data model class
@RealmModel()
class _Item {
  @PrimaryKey()
  late final int id;
  late final String name;
  @Ignored()
  late Color color = CatalogModel.GetColor(0);
  late final int price = 0;
}

/// A proxy of the catalog of items the user can buy.
///
/// In a real app, this might be backed by a backend and cached on device.
/// In this sample app, the catalog is procedurally generated and infinite.
///
/// For simplicity, the catalog is expected to be immutable (no products are
/// expected to be added, removed or changed during the execution of the app).
class CatalogModel {
  late Realm realm;

  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  CatalogModel() {
    var config = Configuration([Item.schema]);
    realm = Realm(config);

    var allItems = realm.all<Item>();

    if (allItems.isEmpty) {
      realm.write(() {
        realm.add(Item(0, 'Code Smell', price: 0)..color = GetColor(0));
        realm.add(Item(1, 'Control-Flow', price: 1)..color = GetColor(1));
        realm.add(Item(2, 'Interpreter', price: 2)..color = GetColor(2));
        realm.add(Item(3, 'Recursion', price: 3)..color = GetColor(3));
        realm.add(Item(4, 'Sprint', price: 4)..color = GetColor(4));
        realm.add(Item(5, 'Heisenbug', price: 5)..color = GetColor(5));
        realm.add(Item(6, 'Spaghetti', price: 6)..color = GetColor(6));
        realm.add(Item(7, 'Hydra-Code', price: 7)..color = GetColor(7));
        realm.add(Item(8, 'Off-By-One', price: 8)..color = GetColor(8));
        realm.add(Item(9, 'Scope', price: 9)..color = GetColor(9));
        realm.add(Item(10, 'Callback', price: 10)..color = GetColor(10));
        realm.add(Item(11, 'Closure', price: 11)..color = GetColor(11));
        realm.add(Item(12, 'Automata', price: 12)..color = GetColor(12));
        realm.add(Item(13, 'Bit-Shift', price: 13)..color = GetColor(13));
        realm.add(Item(14, 'Currying', price: 14)..color = GetColor(14));
      });
    }
  }

  static Color GetColor(int num) => Colors.primaries[num % Colors.primaries.length];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) {
    var objId = id % 14;

    var item = realm.find<Item>(objId) as Item;
    return item;
  }

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}
