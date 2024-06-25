////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2022 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
library;

import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';
import 'package:realm_dart/realm.dart';

part 'time_track.realm.dart';

@RealmModel()
class _Category {
  @PrimaryKey()
  late String name;
}

@RealmModel()
class _Now {
  @Indexed()
  late int time; // no DateTime yet (stay tuned). Instead we store microsecondsSinceEpoch.
  _Category? category; // has to be nullable (a realm restriction).
}

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

  Category getCategory(String name) => find<Category>(name) ?? Category(name);

  Now newNow(Category category) {
    final now = Now(
      DateTime.now().microsecondsSinceEpoch,
      category: category,
    );
    write(() => add(now));
    return now;
  }
}

abstract class CommandBase extends Command<Future<void>> {
  @override
  final String name;
  @override
  final String description;

  CommandBase(this.name, this.description);

  @override
  Future<void> run() async {
    final config = Configuration.local([Category.schema, Now.schema]);
    final realm = Realm(config);
    try {
      await runWithRealm(realm);
    } finally {
      // Always remember to close!
      realm.close();
      Realm.shutdown();
    }
  }

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
  static const lines = 'lines';

  WatchCommand() : super('watch', 'monitor entries as they happen') {
    argParser.addOption(lines, abbr: 'l', help: 'the number of lines top output');
  }

  @override
  Future<void> runWithRealm(Realm realm) async {
    final n = int.tryParse(argResults![lines] ?? '') ?? 5;

    // Find all todays entries
    final today = realm.entriesSince(DateTime.now().midnight);

    // Output changes as they happen
    await for (final changes in today.changes) {
      console.clearScreen();
      console.displayEntries(changes.results.takeLast(n));
    }
  }
}

class ClearCommand extends CommandBase {
  ClearCommand() : super('clear', 'delete all existing entries');

  @override
  Future<void> runWithRealm(Realm realm) async => realm.deleteAllEntries();
}

class ShowCommand extends CommandBase {
  static const since = 'since';
  final today = DateTime.now().midnight;

  ShowCommand() : super('show', 'show all existing entries') {
    argParser.addOption(since, abbr: 's', help: 'show entries since', defaultsTo: today.toString());
  }

  @override
  Future<void> runWithRealm(Realm realm) async {
    final s = DateTime.tryParse(argResults![since]) ?? today;
    console.displayEntries(realm.entriesSince(s));
  }
}

void main(List<String> arguments) async {
  final runner = CommandRunner<Future<void>>(
    "time_track",
    "Track time with the MongoDB Realm Dart SDK",
    suggestionDistanceLimit: 4,
  )
    ..addCommand(ClearCommand())
    ..addCommand(NowCommand())
    ..addCommand(ShowCommand())
    ..addCommand(WatchCommand());
  await runner.run(arguments);
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
            tt.category!.name,
            tt.duration ?? '-',
          ]
      ]);
    write(table.render());
  }
}
