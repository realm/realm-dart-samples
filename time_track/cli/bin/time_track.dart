import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_console/dart_console.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path_;
import 'package:realm_dart/realm.dart';

import 'model/category.dart';
import 'model/now.dart';
import 'model/settings.dart';

extension on Now {
  Now? get next => realm.firstEntryAfter(DateTime.fromMicrosecondsSinceEpoch(time));
  Duration? get duration {
    final n = next;
    return n != null ? Duration(microseconds: n.time - time) : null;
  }
}

extension on Realm {
  RealmResults<Now> entriesSince(DateTime since) => query<Now>(r'time > $0 SORT(time ASCENDING)', [since.microsecondsSinceEpoch]);

  Now? get latestEntry => query<Now>('TRUEPREDICATE SORT(time DESCENDING)').firstOrNull;

  Now? firstEntryAfter(DateTime time) => entriesSince(time).firstOrNull;

  void deleteAllEntries() => write(() => deleteMany(all<Now>()));

  Category getCategory(String name) {
    final bytes = utf8.encoder.convert(name);
    final digest = sha1.convert(bytes);
    final oid = ObjectId.fromBytes(digest.bytes.sublist(0, 12));
    return find<Category>(oid) ?? Category(oid, name);
  }

  Now newNow(Category category) {
    final timestamp = DateTime.now();
    final now = Now(
      ObjectId(), //.fromTimestamp(timestamp),
      timestamp.microsecondsSinceEpoch,
      category: category,
    );
    write(() => add(now));
    return now;
  }
}

final _schemaObjects = [Category.schema, Now.schema];

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
      Realm.logger.info('closing');
      realm.close();
      Realm.logger.info('closed');
    }
  }

  late final Future<Configuration> config = Future.value(Configuration.disconnectedSync(_schemaObjects, path: path));

  Future<void> runWithRealm(Realm realm);
}

class NowCommand extends CommandBase {
  NowCommand() : super('now', 'register a time entry');

  @override
  Future<void> runWithRealm(Realm realm) async {
    final arguments = argResults!.rest;
    if (arguments.isNotEmpty) {
      // Find existing category or create a new
      final name = arguments.join(' ');
      final category = realm.getCategory(name);

      // Find latest entry, if any
      var latest = realm.latestEntry;

      // If category changed, then create a new entry
      if (latest?.category != category) {
        latest = realm.newNow(category);
      }

      console.displayEntry(latest!);
    }
  }
}

class WatchCommand extends CommandBase {
  static const linesOption = 'lines';

  WatchCommand() : super('watch', 'monitor entries as they happen') {
    argParser.addOption(linesOption, abbr: linesOption[0], help: 'the number of lines top output');
  }

  @override
  Future<void> runWithRealm(Realm realm) async {
    final n = int.tryParse(argResults![linesOption] ?? '') ?? 5;

    // Find all todays entries
    final today = realm.entriesSince(DateTime.now().midnight);

    // Output changes as they happen
    console.hideCursor();
    console.clearScreen();
    await for (final changes in today.changes) {
      if (changes.deleted.isNotEmpty) console.clearScreen();
      console.cursorPosition = Coordinate(0, 0);
      console.displayEntries(changes.results.takeLast(n));
    }
  }
}

class ClearCommand extends CommandBase {
  ClearCommand() : super('clear', 'delete all existing entries');

  @override
  Future<void> runWithRealm(Realm realm) async {
    console.write('Do you really want to clear all time entries? (Y/N) ');
    if (console.readLine(cancelOnBreak: true, cancelOnEscape: true) == 'Y') {
      realm.deleteAllEntries();
      console.writeLine('Cleared!');
    } else {
      console.writeLine('Aborted!');
    }
  }
}

class ShowCommand extends CommandBase {
  static const sinceOption = 'since';
  late final today = DateTime.now().midnight;

  ShowCommand() : super('show', 'show all entries since a given timestamp') {
    argParser.addOption(sinceOption, abbr: sinceOption[0], help: 'show entries since', defaultsTo: today.toString());
  }

  @override
  Future<void> runWithRealm(Realm realm) async {
    final s = DateTime.tryParse(argResults![sinceOption]) ?? today;

    final entries = realm.entriesSince(s);
    console.displayEntries(entries);

    final totals = entries.fold<Map<String, Duration>>({}, (acc, entry) {
      final d = entry.duration ?? Duration.zero;
      return acc..update(entry.category!.name, (value) => value + d, ifAbsent: () => d);
    });
    console.displayTotals(totals);
  }
}

class LogInCommand extends CommandBase {
  static const appIdOption = 'appId';
  static const baseUrlOption = 'baseUrl';
  static const emailOption = 'email';
  static const passwordOption = 'password';

  LogInCommand() : super('log-in', 'log in to MongoDB Atlas App Service') {
    argParser
      ..addOption(appIdOption, abbr: appIdOption[0], help: 'the realm application id on MongoDB Atlas')
      ..addOption(baseUrlOption, abbr: baseUrlOption[0], help: 'Base URL to contact server', defaultsTo: 'https://realm.mongodb.com')
      ..addOption(emailOption, abbr: emailOption[0], help: 'email of user')
      ..addOption(passwordOption, abbr: passwordOption[0], help: 'password of user');
  }

  @override
  Future<void> runWithRealm(Realm realm) async {
    final appId = argResults![appIdOption] as String;
    final baseUrl = Uri.tryParse(argResults![baseUrlOption]);
    final email = argResults![emailOption] as String;
    final password = argResults![passwordOption] as String;

    final app = App(AppConfiguration(appId, baseUrl: baseUrl, baseFilePath: basePath));
    final credentials = Credentials.emailPassword(email, password);

    Realm.logger.info('log in');
    await app.logIn(credentials);
    Realm.logger.info('log in done!');

    // Update settings
    Settings.appId.value = appId;
    Settings.baseUrl.value = baseUrl.toString();

    Realm.logger.info('command done!');
  }
}

class LogOutCommand extends CommandBase {
  LogOutCommand() : super('log-out', 'Log out user, if any is currently logged in');

  @override
  Future<void> runWithRealm(Realm realm) async {
    // Get user (should already be logged in)
    final appId = Settings.appId.value;
    final baseUrl = Uri.parse(Settings.baseUrl.value);
    final app = App(AppConfiguration(appId, baseUrl: baseUrl, baseFilePath: basePath));
    await app.currentUser!.logOut();
  }
}

class SyncCommand extends CommandBase {
  SyncCommand() : super('sync', 'synchronize with MongoDB Atlas');

  @override
  Future<void> runWithRealm(Realm realm) async {
    // Get user (should already be logged in)
    final appId = Settings.appId.value;
    final baseUrl = Uri.parse(Settings.baseUrl.value);
    final app = App(AppConfiguration(appId, baseUrl: baseUrl, baseFilePath: basePath));
    final user = app.currentUser!;

    // Swizzle realm
    realm.close();
    final config = Configuration.flexibleSync(user, _schemaObjects, path: path);
    realm = Realm(config);

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
    realm.close();
  }
}

const pathOption = 'path';
const appIdOption = 'appId';
const baseUrlOption = 'baseUrl';
const verboseOption = 'verbose';

void main(List<String> arguments) async {
  final runner = CommandRunner<Future<void>>(
    "time_track",
    "Track time with the MongoDB Realm Dart SDK",
    suggestionDistanceLimit: 4,
  )
    ..addCommand(ClearCommand())
    ..addCommand(LogInCommand())
    ..addCommand(LogOutCommand())
    ..addCommand(NowCommand())
    ..addCommand(ShowCommand())
    ..addCommand(SyncCommand())
    ..addCommand(WatchCommand())
    ..argParser.addOption(
      pathOption,
      abbr: pathOption[0],
      help: 'set the path to the database directory',
      defaultsTo: 'time_track',
    )
    ..argParser.addFlag(
      verboseOption,
      abbr: verboseOption[0],
      help: 'Add lots of trace',
      defaultsTo: false,
    );

  await runner.run(arguments);
  Realm.logger.info('shutdown');
  Realm.shutdown();
  Realm.logger.info('shutdown done');
}

final console = Console();

extension<T> on Iterable<T> {
  T? get firstOrNull => cast<T?>().firstWhere((_) => true, orElse: () => null);
  Iterable<T> takeLast(int n) => skip(max(0, length - n)); // only efficient on EfficientLengthIterable
}

extension on DateTime {
  DateTime get midnight => DateTime(year, month, day);
}

extension on Console {
  void displayEntry(Now entry) => writeLine('${DateTime.fromMicrosecondsSinceEpoch(entry.time)}: ${entry.category!.name}');

  void displayEntries(Iterable<Now> entries) {
    final table = Table()
      ..insertColumn(header: 'Time')
      ..insertColumn(header: 'Category')
      ..insertColumn(header: 'Duration')
      ..insertRows([
        for (final tt in entries)
          [
            DateTime.fromMicrosecondsSinceEpoch(tt.time),
            tt.category?.name ?? '-',
            tt.duration ?? '-',
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
