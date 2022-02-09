![Realm](https://github.com/realm/realm-dart/raw/master/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

## Time track

A simple time tracking application using Realm Dart SDK for persistence 

[![asciicast](https://asciinema.org/a/rE6itBIrq0Ts4JNkzhaFUAPI1.png)](https://asciinema.org/a/rE6itBIrq0Ts4JNkzhaFUAPI1)


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
    // if not compiled
    ./dart run bin/time_track work
    ./dart run bin/time_track eat
    ./dart run bin/time_track sleep
    
    // if compiled
    ./now work
    ./now eat
    ./now work
    ./now sleep
```

For further information see: https://github.com/realm/realm-dart.

##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 