![Realm](https://github.com/realm/realm-dart/raw/main/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

## Realm Dart sample

A command-line application using Realm Dart SDK.

This sample uses the [Realm Dart SDK](https://www.mongodb.com/docs/realm/sdk/flutter/#dart-standalone-realm) to demonstrates the following simple operations with a local realm:

- Create and open local realm
- Add objects to realm
- Edit object in realm
- Read all objects of a type
- Query subset of objects in realm
- Close realm

## Realm Dart SDK

Realm Dart package is published to [realm_dart](https://pub.dev/packages/realm_dart).

## Environment setup for Realm Dart

* Realm Dart supports Windows, Mac and Linux platforms.

* Dart SDK 3.0.2 or newer

## Usage

* Get packages to the Dart application.

    ```
    dart pub get
    ```

* Install the `realm_dart` package into the application. This downloads and copies the required native binaries to the app directory. Supported platforms are Windows, MacOS, and Linux.

    ```
    dart run realm_dart install
    ```

*  Run the application

    ```
    dart run
    ```

##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 

