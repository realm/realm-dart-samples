![Realm](https://github.com/realm/realm-dart/raw/master/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

## Time track

A simple time tracking application using Realm Dart SDK for persistence. 

What follows is a short [asciinema](https://asciinema.org/) recording of building and using it. You can copy paste directly from the recording to your terminal. Note that I'm using [fish](https://fishshell.com/), so you may have to tweak a bit, if you are using another shell.

[![asciicast](https://asciinema.org/a/rE6itBIrq0Ts4JNkzhaFUAPI1.svg)](https://asciinema.org/a/rE6itBIrq0Ts4JNkzhaFUAPI1)


## Build
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
    dart compile exe bin/time_track.dart 
```

## Usage
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

For further information see: https://github.com/realm/realm-dart.

##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 