![Realm](https://github.com/realm/realm-dart/raw/main/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

# Time track

A simple time tracking application using Realm Dart SDK for persistence.

This sample is using [Realm Dart](https://www.mongodb.com/docs/realm/sdk/flutter/#dart-standalone-realm) and provides custom CLI with the following commands:
- `now` registers a time entry
- `clear` deletes all existing entries
- `show` shows all existing entries
- `watch` monitors entries as they happen

The command `watch` is using RealmResult.changes to listen for changes when the contents of the collection change.

## Realm Dart SDK

Realm Dart package is published to [realm_dart](https://pub.dev/packages/realm_dart).

## Environment setup for Realm Dart

* Realm Dart supports Windows, Mac and Linux platforms.

* Dart SDK ^2.17.5 or newer

## Usage

* Get packages to the Dart application.
```
    dart pub get
```
* Install the `realm_dart` package into the application. This downloads and copies the required native binaries to the app directory. Supported platforms are Windows, MacOS, and Linux.
```
    dart run realm_dart install
```
* Generate Dart binding for Realm Database.
```
    dart run realm_dart generate
```
* [Optional] Compile to native for speed.
```
    dart compile exe bin/time_track.dart 
```
* Run watch in separate shell
```
    // if not compiled
    dart run bin/time_track.dart watch
    
    // if compiled
    bin/time_track.exe watch
```

* Take for a spin
```
    // if not compiled
    dart run bin/time_track.dart now work
    dart run bin/time_track.dart now eat
    dart run bin/time_track.dart now work
    dart run bin/time_track.dart now sleep
    
    // if compiled
    bin/time_track.exe now work
    bin/time_track.exe now eat
    bin/time_track.exe now work
    bin/time_track.exe now sleep
```

What follows is a short [asciinema](https://asciinema.org/) recording of building and using it. You can copy paste directly from the recording to your terminal. Note that a custom shell [fish](https://fishshell.com/) is used for the recording, so you may have to tweak a bit, if you are using another shell.

[![asciicast](https://asciinema.org/a/rE6itBIrq0Ts4JNkzhaFUAPI1.svg)](https://asciinema.org/a/rE6itBIrq0Ts4JNkzhaFUAPI1)

For further information see: https://github.com/realm/realm-dart.

##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 