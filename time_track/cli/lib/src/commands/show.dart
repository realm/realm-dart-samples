import 'package:domain/domain.dart';
import 'package:realm_dart/realm.dart';

import 'base.dart';

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

    final totals = entries.toList().fold<Map<String, Duration>>({}, (acc, entry) {
      final d = entry.duration ?? Duration.zero;
      return acc..update(entry.category?.fullName ?? 'Unknown', (value) => value + d, ifAbsent: () => d);
    });
    console.displayTotals(totals);
  }
}
