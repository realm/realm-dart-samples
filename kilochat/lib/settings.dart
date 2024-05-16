import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:realm/realm.dart';

part 'settings.realm.dart';

@RealmModel()
class _Workspace {
  @PrimaryKey()
  late String appId; // atlas app service id
  late String name; // for display
  ObjectId? currentChannelId; // current channel

  App get app => _appCache.putIfAbsent(
      appId, () => App(AppConfiguration(appId, httpClient: HttpClient())));
}

final _appCache = <String, App>{};

@RealmModel()
class _Settings {
  _Workspace? workspace; // current workspace
}

final _realm = Realm(
  Configuration.local(
    [Settings.schema, Workspace.schema],
    path: path.join(Configuration.defaultStoragePath, 'settings.realm'),
  ),
);

// local persisted singleton
final _settings = _realm
    .write(() => _realm.all<Settings>().firstOrNull ?? _realm.add(Settings()));

Workspace? get currentWorkspace => _settings.workspace;
set currentWorkspace(Workspace? value) =>
    _realm.write(() => _settings.workspace = value);

void addOrUpdateWorkspace(Workspace workspace) {
  _realm.write(() => _realm.add(workspace, update: true));
}

void deleteWorkspace(Workspace workspace) {
  _realm.write(() => _realm.delete(workspace));
}

Stream<Workspace?> get workspaceChanges =>
    _settings.changes.map((c) => c.object.workspace);

RealmResults<Workspace> get workspaces =>
    _realm.query<Workspace>('TRUEPREDICATE SORT(name ASCENDING)');
