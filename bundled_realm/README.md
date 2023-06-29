<picture>
    <source srcset="https://raw.githubusercontent.com/realm/realm-dart/main/media/logo-dark.svg" media="(prefers-color-scheme: dark)" alt="realm by MongoDB">
    <img src="https://raw.githubusercontent.com/realm/realm-dart/main/media/logo.svg" alt="realm by MongoDB">
</picture>

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

# Bundled realm sample

A Flutter application with pre-initialized realm file that is shipped with the application.

This application demonstrates how to bundle a realm file with data, and load the bundled realm into the Flutter app.

## Realm Flutter SDK

Realm Flutter package is published to [realm](https://pub.dev/packages/realm).

## Environment

* Realm Flutter supports iOS, Android, Windows, Mac and Linux platforms.

* Flutter 3.10.2 or newer
* For Flutter Desktop environment setup, see [Desktop support for Flutter](https://docs.flutter.dev/desktop).

## Getting Started

### How to populate initial data
```dart
final config = Configuration.local([Car.schema], path: "realm/initial.realm");
final realm = Realm(config);
realm.write(() {
    realm.add(Car("VW", model: "1999"));
    realm.add(Car("Renault", model: "1990"));
});
```
### How to bundle realm
Add the path to the realm as an asset key to your pubspec.yaml
```dart
flutter:
  assets:
    - realm/initial.realm
```

### How to load bundled realm
Create a configuration and just before to open a realm check if the realm file doesn't exist at `config.path` location to ensure that this is the first time you try to open a realm.
Then copy the bundled realm from assets into `config.path` location. After that the realm that is opened will be the pre-poluted realm.
```dart
import 'package:flutter/services.dart';

Future<Realm> initRealm(String assetKey) async {
  final config = Configuration.local([Car.schema]);
  final file = File(config.path);
  // await file.delete(); // <-- uncomment this to start over on every restart
  if (!await file.exists()) {
    ByteData realmBytes = await rootBundle.load(assetKey);
    await file.writeAsBytes(
      realmBytes.buffer.asUint8List(realmBytes.offsetInBytes, realmBytes.lengthInBytes),
      mode: FileMode.write,
    );
  }
  return Realm(config);
}
```

You can call `initRealm` before `runApp` for example:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  realm = await initRealm("realm/initial.realm");
  runApp(const MyApp());
}
```
