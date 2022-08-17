# bundled_realm

A new Flutter project that demonstrates how to bundle and load initially populated realm in the app.

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
  if (!await file.exists()) {
    ByteData realmBytes = await rootBundle.load(assetKey);
    await file.writeAsBytes(realmBytes.buffer.asUint8List(realmBytes.offsetInBytes, realmBytes.lengthInBytes), mode: FileMode.write);
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