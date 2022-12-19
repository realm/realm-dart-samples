![Realm](https://github.com/realm/realm-dart/raw/main/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

# Realm Dart Samples

This repo contains Flutter and Dart samples that demonstate the usage of [Realm Flutter and Dart Standalone SDKs](https://www.mongodb.com/docs/realm/sdk/flutter/).

To build your own app with Realm, use the [realm](https://pub.dev/packages/realm) package for Flutter and the [realm_dart](https://pub.dev/packages/realm_dart) package for Dart applications.

The Realm Flutter and Realm Dart SDK repository is located at https://github.com/realm/realm-dart

You may find the [Quick Start - Flutter SDK]( https://www.mongodb.com/docs/realm/sdk/flutter/quick-start/) helpful if you are using Realm for the first time.
To learn more about using Realm with Atlas App Services, refer to the [Atlas Device Sync](https://www.mongodb.com/docs/realm/sdk/flutter/sync/) and [connecting to Atlas App Services](https://www.mongodb.com/docs/realm/sdk/flutter/app-services/) documentation.

## [`realm_dart`](https://github.com/realm/realm-dart-samples/tree/main/realm_dart) - Dart console application

This sample is using [Realm Dart SDK](https://www.mongodb.com/docs/realm/sdk/flutter/#dart-standalone-realm) to demonstrates the following simple operations with a local realm:

- open/create local realm
- add/edit objects to realm
- read all object
- query objects from realm
- close realm

To run the app follow the instructions in the README: [realm_dart\README.md](https://github.com/realm/realm-dart-samples/tree/main/realm_dart#readme)

## [`provider_shopper`](https://github.com/realm/realm-dart-samples/tree/main/provider_shopper) - Flutter application

A Flutter sample app from [flutter sample repo](https://github.com/flutter/samples/tree/master/provider_shopper) that shows a state management approach. This app is modified to be integrated with a local realm using [Realm Flutter SDK](https://www.mongodb.com/docs/realm/sdk/flutter/).
The list with all the available items are initialized into `CatalogModel` class as realm objects added to a realm.

If the users add any items to their shopping cart, these irems are added to a memory collection in `CartModel` class. Only initial list of items is stored to the realm.

You can leave the credentials empty on the login screen.

To run the app follow the instructions: [provider_shopper\ReadMe.md](https://github.com/realm/realm-dart-samples/tree/main/provider_shopper#readme)

## [`time_track`](https://github.com/realm/realm-dart-samples/tree/main/time_track) - Dart console application listener

This sample is using [Realm Dart Standalone SDK](https://www.mongodb.com/docs/realm/sdk/flutter/#dart-standalone-realm) and provides custom CLI with the following commands:
- `now` registers a time entry
- `clear` deletes all existing entries
- `show` shows all existing entries
- `watch` monitors entries as they happen

The command `watch` is using RealmResult.changes to listen for changes when the contents of the collection change.

To run the app follow the instructions in the README: [time_track\README.md](https://github.com/realm/realm-dart-samples/tree/main/time_track#readme)

## [`dart_flexible_sync`](https://github.com/realm/realm-dart-samples/tree/main/dart_flexible_sync) - Dart console application with flexible sync

A simple command-line application using the [Realm Dart Standalone SDK](https://www.mongodb.com/docs/realm/sdk/flutter/#dart-standalone-realm) and Flexible Sync with [Atlas App Services application](https://www.mongodb.com/docs/atlas/app-services/).

This sample demonstrates the usage of [Atlas Device Sync with Flexible Sync](https://www.mongodb.com/docs/realm/sdk/flutter/sync/) and the Realm Dart Standalone SDK.
Writing to a synced realm sends the data automatically to the a collection in MongoDB Atas. The synced realm is subscribed to a query only for items matching specific criteria.
This causes the synced realm to be populated only with specific items matching the query.
Items in the MongoDB collection on Atlas that do not match the query do not sync to the device.

To run the app follow the instructions in the README: [dart_flexible_sync/README.md](https://github.com/realm/realm-dart-samples/tree/main/dart_flexible_sync#readme)

## [`flutter_flexible_sync`](https://github.com/realm/realm-dart-samples/tree/main/flutter_flexible_sync) - Flutter application with flexible sync

A Flutter application using the [Realm Flutter SDK](https://www.mongodb.com/docs/realm/sdk/flutter/), Atlas Device Sync with Flexible Sync, and [Atlas App Services application](https://www.mongodb.com/docs/atlas/app-services/).

This sample demonstrates the usage of Flexible Sync. 
Writing to a synced realm named `db_allTasks.realm` sends the data automatically to a linked MongoDB collection on Atlas.
Then the data are downloaded back by the synchronization process to two separate realms,
`db_importantTasks.realm` and  `db_normalTaks.realm`, filtered by specific subscription query.

To run the app follow the instructions in the README: [flutter_flexible_sync/README.md](https://github.com/realm/realm-dart-samples/tree/main/flutter_flexible_sync#readme)

## [`bundled_realm`](https://github.com/realm/realm-dart-samples/tree/main/bundled_realm) - Flutter application with pre-initialized realm file

A Flutter application that demonstrates how to bundle a realm file with data, and load the bundled realm into the app.


To see how to load pre-initialized realm from Flutter assets, follow the instructions in the README: [bundled_realm/README.md](https://github.com/realm/realm-dart-samples/tree/main/bundled_realm#readme)

*The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google.*