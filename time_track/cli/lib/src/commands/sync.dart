import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:domain/domain.dart';
import 'package:realm_dart/realm.dart';

import '../settings.dart';
import 'base.dart';

class SyncCommand extends CommandBase {
  SyncCommand() : super('sync', 'synchronize with MongoDB Atlas');

  @override
  Future<Configuration> get config async {
    // Get user (should already be logged in)
    final appId = Settings.appId.value;
    final baseUrl = Uri.parse(Settings.baseUrl.value);
    final app = App(AppConfiguration(appId, baseUrl: baseUrl, baseFilePath: basePath));
    final user = app.currentUser!;

    return Configuration.flexibleSync(user, schemaObjects, path: path);
  }

  @override
  Future<void> runWithRealm(Realm realm) async {
    // Initiate subscriptions
    final subs = realm.subscriptions;
    subs.update((mutableSubscriptions) {
      mutableSubscriptions.add(realm.all<Category>());
      mutableSubscriptions.add(realm.all<Now>());
    });
    await subs.waitForSynchronization();

    // Monitor progress
    final session = realm.syncSession;
    final up = session.getProgressStream(ProgressDirection.upload, ProgressMode.reportIndefinitely);
    final down = session.getProgressStream(ProgressDirection.download, ProgressMode.reportIndefinitely);

    console.clearScreen();

    void trace(String header, SyncProgress progress, int row) {
      if (!verbose) {
        console.cursorPosition = Coordinate(row, 0);
        console.writeAligned('$header: ', 10, TextAlignment.right);
        console.writeAligned('${progress.transferredBytes} / ', 10, TextAlignment.right);
        console.write('${progress.transferableBytes}');
      }
    }

    up.listen((p) => trace('Upload', p, 0));
    down.listen((p) => trace('Download', p, 1));

    // Wait for cancellation
    await ProcessSignal.sigint.watch().first;
    console.writeLine('Synchronization stopped!');
  }
}
