import 'package:realm_dart/realm.dart';

part 'settings.g.dart';

enum Settings {
  appId(''),
  baseUrl('https://realm.mongodb.com'),
  logLevel('info');

  final String defaultValue;
  const Settings(this.defaultValue);

  static void init(String path) => _realm = Realm(Configuration.local([Setting.schema], path: path));

  String get value => _realm.find<Setting>(name)?.value ?? defaultValue;
  set value(String v) => _realm.write(() => _realm.add<Setting>(Setting(name, v), update: true));
}

late Realm _realm;

@RealmModel()
class _Setting {
  @PrimaryKey()
  late String key;
  late String value;
}
