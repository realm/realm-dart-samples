////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

import 'package:realm_dart/realm.dart';

part 'myapp.g.dart';

@RealmModel()
class _Car {
  late String make;
}

@RealmModel()
class _Person {
  late String name;
}

void main(List<String> arguments) {
  var config = Configuration([Car.schema, Person.schema]);
  var realm = Realm(config);

  realm.write(() {
    print('Creating Realm object of type Car');
    var car = realm.add(Car('Audi'));
    print('The car is ${car.make}');

    car.make = 'VW';
    print('The car is ${car.make}');
  });

  var allCars = realm.all<Car>();
  var indexedCar = allCars[0];
  print('The indexedCar is ${indexedCar.make}');

  realm.write(() {
    print('Creating more cars');
    var car = realm.add(Car('Audi'));
    print('The car is ${car.make}');
  });

  var filteredCars = realm.all<Car>().query("make == 'Audi'");
  print('Found ${filteredCars.length} Audi cars');

  print('Done');
}
