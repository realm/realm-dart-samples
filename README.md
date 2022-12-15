![Realm](https://github.com/realm/realm-dart/raw/main/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

# Description

This repo contains Realm Flutter and Realm Dart SDK samples. 

The Realm Flutter and Realm Dart SDK are located at https://github.com/realm/realm-dart

# Samples
## [`realm_dart`](https://github.com/realm/realm-dart-samples/tree/main/realm_dart) - Dart console application

This sample is using Realm Dart SDK to demonstrates simple operations with a local realm:

- open/create local realm;
- add/edit objects to realm;
- read all object;
- query objects from realm;
- close realm.

To run the app follow the instructions: [realm_dart\ReadMe.md](https://github.com/realm/realm-dart-samples/tree/main/realm_dart#readme)

## [`provider_shopper`](https://github.com/realm/realm-dart-samples/tree/main/provider_shopper) - Flutter application

A Flutter sample app from [flutter sample repo](https://github.com/flutter/samples/tree/master/provider_shopper) that shows a state management approach. This app is modified to be integrated with a local realm using Realm Flutter SDK.
The list with all the available items are initialized into `CatalogModel` class as realm objects added to a realm.

If the users add any items to their shopping cart, these irems are added to a memory collection in `CartModel` class. Only initial list of items is stored to the realm.

You can leave the credentials empty on the login screen.

To run the app follow the instructions: [provider_shopper\ReadMe.md](https://github.com/realm/realm-dart-samples/tree/main/provider_shopper#readme)

## [`time_track`](https://github.com/realm/realm-dart-samples/tree/main/time_track) - Dart console application listener

This sample is using Realm Dart SDK and provides custom CLI with commands `clear`, `show`, `watch`, `now`.
- `now` registers a time entry;
- `clear` deletes all existing entries;
- `show` shows all existing entries;
- `watch` monitors entries as they happen;

The command `watch` is using RealmResult.changes to listen for changes when the contents of the collection changes.

To run the app follow the instructions: [time_track\ReadMe.md](https://github.com/realm/realm-dart-samples/tree/main/time_track#readme)

## Dart console application with flexible sync [`dart_flexible_sync`](https://github.com/realm/realm-dart-samples/tree/main/dart_flexible_sync)

## Flutter application with flexible sync [`flutter_flexible_sync`](https://github.com/realm/realm-dart-samples/tree/main/flutter_flexible_sync)

## Flutter application with pre-initialized realm file [`bundled_realm`](https://github.com/realm/realm-dart-samples/tree/main/bundled_realm)

# Usage 
Check the README.md files of the samples for instructions how to run them.



#### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 
 