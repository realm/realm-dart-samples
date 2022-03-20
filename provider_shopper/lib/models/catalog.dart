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
  late int id;
  
  late String name;

  late int price = 0;

  @Ignored()
  late Color color = CatalogModel.GetColor(0);
}

/// A proxy of the catalog of items the user can buy.
class CatalogModel {
  late Realm realm;

  CatalogModel() {
    var config = Configuration([Item.schema]);
    realm = Realm(config);

    var allItems = realm.all<Item>();

    if (allItems.isEmpty) {
      realm.write(() {
        realm.addAll([
          Item(0, 'Code Smell', price: 0)..color = GetColor(0),
          Item(1, 'Control-Flow', price: 1)..color = GetColor(1),
          Item(2, 'Interpreter', price: 2)..color = GetColor(2),
          Item(3, 'Recursion', price: 3)..color = GetColor(3),
          Item(4, 'Sprint', price: 4)..color = GetColor(4),
          Item(5, 'Heisenbug', price: 5)..color = GetColor(5),
          Item(6, 'Spaghetti', price: 6)..color = GetColor(6),
          Item(7, 'Hydra-Code', price: 7)..color = GetColor(7),
          Item(8, 'Off-By-One', price: 8)..color = GetColor(8),
          Item(9, 'Scope', price: 9)..color = GetColor(9),
          Item(10, 'Callback', price: 10)..color = GetColor(10),
          Item(11, 'Closure', price: 11)..color = GetColor(11),
          Item(12, 'Automata', price: 12)..color = GetColor(12),
          Item(13, 'Bit-Shift', price: 13)..color = GetColor(13),
          Item(14, 'Currying', price: 14)..color = GetColor(14)
        ]);
      });
    }
  }

  static Color GetColor(int num) => Colors.primaries[num % Colors.primaries.length];

  /// Get item by [id].
  Item getById(int id) {
    final objId = id % 14;

    final item = realm.find<Item>(objId)!;
    return item;
  }

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}