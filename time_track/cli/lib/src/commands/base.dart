import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path_;
import 'package:realm_dart/realm.dart';

import 'package:domain/domain.dart';

import '../settings.dart';

abstract class CommandBase extends Command<Future<void>> {
  @override
  final String name;
  @override
  final String description;

  CommandBase(this.name, this.description);

  late final basePath = Directory(globalResults![pathOption])..createSync(recursive: true);
  late final path = path_.join(basePath.path, 'time_track.realm');
  late final settingsPath = path_.join(basePath.path, 'settings.realm');

  late final verbose = globalResults![verboseOption] as bool;

  @override
  Future<void> run() async {
    print(settingsPath);
    Settings.init(settingsPath);

    // Setup logging
    final sw = Stopwatch()..start();
    Realm.logger = Logger.detached('time_track')
      ..level = verbose ? RealmLogLevel.all : RealmLogLevel.error
      ..onRecord.listen((event) {
        print('${sw.elapsedMilliseconds} $event');
      });

    final realm = Realm(await config);
    try {
      await runWithRealm(realm);
    } finally {
      realm.close();
    }
  }

  late final Future<Configuration> config = Future.value(Configuration.disconnectedSync(schemaObjects, path: path));

  Future<void> runWithRealm(Realm realm);
}

const pathOption = 'path';
const appIdOption = 'appId';
const baseUrlOption = 'baseUrl';
const verboseOption = 'verbose';

final console = Console();

extension ConsoleEx on Console {
  void displayEntry(Now entry) => writeLine('${entry.time.formatted}: ${entry.category!.fullName}');

  void displayEntries(Iterable<Now> entries) {
    final table = Table()
      ..insertColumn(header: 'Time')
      ..insertColumn(header: 'Category')
      ..insertColumn(header: 'Duration')
      ..insertRows([
        for (final tt in entries)
          [
            tt.time.formatted,
            tt.category?.fullName ?? 'Unknown',
            tt.duration?.formatted ?? '-',
          ]
      ]);
    write(table.render());
  }

  void displayTotals(Map<String, Duration> totals) {
    final table = Table()
      ..insertColumn(header: 'Category')
      ..insertColumn(header: 'Duration')
      ..insertRows([
        for (final t in totals.entries) [t.key, t.value]
      ]);
    write(table.render());
  }
}
