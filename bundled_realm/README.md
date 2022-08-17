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
Create a function in your app
```dart
Future<void> copyAsset(BuildContext context, String assetKey, String path) async {
  var assets = DefaultAssetBundle.of(context);
  final byteData = await assets.load(assetKey);
  final file = File(path);
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes), mode: FileMode.write);
}
```
Create a function to copy initial.realm into default realm location before realm to be opened
```dart
Realm loadInitialRealmOnFirstTimeOpening(BuildContext context) {
  final defaultRealmPathConfig = Configuration.local([Car.schema]).path;
  final config = Configuration.local([Car.schema], initialDataCallback: (realm) async {
    await copyAsset(context, "realm/initial.realm", defaultRealmPathConfig);
  });
  return Realm(config);
}
```
