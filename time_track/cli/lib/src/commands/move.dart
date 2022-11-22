import 'package:domain/domain.dart';
import 'package:realm_dart/realm.dart';

import 'base.dart';

class MoveCommand extends CommandBase {
  static const fromOption = 'from';
  static const toOption = 'to';

  MoveCommand() : super('move', 'move a time entry') {
    argParser
      ..addOption(fromOption, abbr: fromOption[0], help: 'the index of the time entry to move')
      ..addOption(toOption, abbr: toOption[0], help: 'the index to move to');
  }

  @override
  Future<void> runWithRealm(Realm realm) async {
    final all = realm.allEntries;
    final max = all.length - 1;

    final from = int.parse(argResults![fromOption] as String).clamp(0, max);
    final to = int.parse(argResults![toOption] as String).clamp(0, max);

    final toMove = all[from];
    final justAfter = all[to];

    realm.write(() => toMove.microsecondsSinceEpoch = (justAfter.microsecondsSinceEpoch + justAfter.next!.microsecondsSinceEpoch) ~/ 2);
  }
}
