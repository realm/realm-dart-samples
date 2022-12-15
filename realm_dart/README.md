![Realm](https://github.com/realm/realm-dart/raw/main/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

## A simple command-line application using Realm Dart SDK

# Realm Dart SDK 

The Realm Dart package is `realm_dart`

## Environment setup for Realm Dart

* Supported platforms are Windows, Mac and Linux.

* Dart SDK ^2.17.5

## Usage

* Add `realm_dart` package to a Dart application.

    ```
    dart pub add realm_dart
    ```

* Install the `realm_dart` package into the application. This downloads and copies the required native binaries to the app directory.

    ```
    dart run realm_dart install
    ``` 
* Import Realm in a dart file (ex. `myapp.dart`).

    ```dart
    import 'package:realm_dart/realm.dart';
    ```

* Declare a part file `myapp.g.dart` in the begining of the `myapp.dart` dart file after all imports.

    ```dart
    import 'dart:io';

    part 'myapp.g.dart';
    ```

* Create a data model class.

    It should start with an underscore `_Car` and be annotated with `@RealmModel()`

    ```dart
    @RealmModel()
    class _Car {
      late String make;
    }
    ```

* To generate RealmObject classes with realm_dart use this command.

    ```
    dart run realm_dart generate
    ```
    A new file `myapp.g.dart` will be created next to the `myapp.dart`.
    
    _*This file should be committed to source control_


*  Run the application

    ```
    dart run
    ```

##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 

