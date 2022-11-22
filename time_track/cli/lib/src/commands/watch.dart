import 'package:dart_console/dart_console.dart';
import 'package:domain/domain.dart';
import 'package:realm_dart/realm.dart';

import 'base.dart';

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
