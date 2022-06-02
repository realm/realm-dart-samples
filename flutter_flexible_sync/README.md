![Realm](https://github.com/realm/realm-dart/raw/master/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

## A simple application using Realm Flutter SDK Flexible Sync with [Atlas App Services application](https://www.mongodb.com/docs/atlas/app-services/).
This sample demonstrates the usage of Flexible Sync. 
Writing to a local realm named `db_allTasks.realm` sends the data automatically to the Atlas Collection.
Then the data are downloaded back by the synchronization process to two separated realms
 `db_importantTasks.realm` and  `db_normalTaks.realm` filtered by specific subscription query.

# Realm Flutter SDK 

The Realm Flutter package is `realm` and it is available in [pub.dev](https://pub.dev/packages/realm)

# Environment

* Flutter ^3.0.1 
* Flutter Mobile on Android and iOS
* Flutter Desktop on Windows, Linux and MacOS

## Usage

Create an account in [realm.mongodb.com](https://realm.mongodb.com)
