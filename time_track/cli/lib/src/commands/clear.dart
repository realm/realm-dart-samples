import 'package:domain/domain.dart';
import 'package:realm_dart/realm.dart';

import 'base.dart';

class ClearCommand extends CommandBase {
  static const forceOption = 'force';

  ClearCommand() : super('clear', 'delete all existing entries') {
    argParser.addFlag(forceOption, abbr: forceOption[0], help: "Don't ask for confirmation", defaultsTo: false);
  }

  @override
  Future<void> runWithRealm(Realm realm) async {
    final force = argResults![forceOption] as bool;
    if (!force) {
      console.write('Are you sure you want to delete all entries? (y/n): ');
      final input = console.readLine();
      if (input != 'y') {
        console.writeLine('Aborted!');
        return;
      }
    }
    realm.write(() => realm.clear());
    console.writeLine('Cleared!');
  }
}
