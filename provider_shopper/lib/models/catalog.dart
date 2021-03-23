// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// Realm: Import realm
import 'package:realm/realm.dart';

// Realm: Declare a part file
part 'catalog.g.dart';

// Realm: Creating a Realm object data model class
class _Item {
  @RealmProperty(primaryKey: true)
  int id;

  @RealmProperty()
  String name;

  @RealmProperty(defaultValue: '42')
  int price;
}

/// A proxy of the catalog of items the user can buy.
///
/// In a real app, this might be backed by a backend and cached on device.
/// In this sample app, the catalog is procedurally generated and infinite.
///
/// For simplicity, the catalog is expected to be immutable (no products are
/// expected to be added, removed or changed during the execution of the app).
class CatalogModel {
  Realm realm;

  CatalogModel() {
    var config = Configuration();
    config.schema.add(Item);

    realm = Realm(config);

      var objects = realm.objects<Item>();

      if (objects.length == 0) {
        realm.write(() {
          realm.create(Item()..id = 0..name = 'Code-Smell'..price = 20);
          realm.create(Item()..id = 1..name = 'Control-Flow'..price = 1);
          realm.create(Item()..id = 2..name = 'Interpreter'..price = 2);
          realm.create(Item()..id = 3..name = 'Recursion'..price = 3);
          realm.create(Item()..id = 4..name = 'Sprint'..price = 4);
          realm.create(Item()..id = 5..name = 'Heisenbug'..price = 5);
          realm.create(Item()..id = 6..name = 'Spaghetti'..price = 6);
          realm.create(Item()..id = 7..name = 'Hydra-Code'..price = 7);
          realm.create(Item()..id = 8..name = 'Off-By-One'..price = 8);
          realm.create(Item()..id = 9..name = 'Scope'..price = 9);
          realm.create(Item()..id = 10..name = 'Callback'..price = 10);
          realm.create(Item()..id = 11..name = 'Closure'..price = 11);
          realm.create(Item()..id = 12..name = 'Automata'..price = 12);
          realm.create(Item()..id = 13..name = 'Bit-Shift'..price = 13);
          realm.create(Item()..id = 14..name = 'Currying'..price = 14);
        });
      }
  }

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) {
    
    //realm objects in the database are not infinte. calculate the real object id
    var objId = id % 14;
   
    var item = realm.find<Item>(objId);
    return item;

  }

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}