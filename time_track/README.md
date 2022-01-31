![Realm](https://github.com/realm/realm-dart/raw/master/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

## A simple time tracking application using Realm Dart SDK for persistence 

## Usage
* Get dependencies (realm_dart)
```
    dart pub get
```
* Install native realm library (supported platforms are Windows, MacOS, and Linux).
```
    dart run realm_dart install
```
* Generate Dart binding for Realm Database
```
    dart run realm_dart generate
```
* [Optional] Compile to native for speed
```
    dart compile exe bin/time_track.dart -o now    
```
* Take for a spin
```
    ./now work
    ./now eat
    ./now work
    ./now sleep
```

For further information see: https://github.com/realm/realm-dart.

##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 