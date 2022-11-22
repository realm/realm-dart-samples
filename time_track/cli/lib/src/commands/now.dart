import 'package:domain/domain.dart';
import 'package:realm_dart/realm.dart';

import 'base.dart';

class NowCommand extends CommandBase {
  NowCommand() : super('now', 'register a time entry');

  @override
  Future<void> runWithRealm(Realm realm) async {
    final arguments = argResults!.rest;
    if (arguments.isNotEmpty) {
      // Find existing category or create a new
      final name = arguments.join(' ').split(',').map((s) => s.trim());
      realm.write(() {
        final category = realm.getCategory(name);

        // Find latest entry, if any
        var latest = realm.latestEntry;

        // If category changed, then create a new entry
        if (latest?.category != category) {
          latest = realm.newNow(category);
        }
        console.displayEntry(latest!);
      });
    } else {
      usageException('You need to specify what is happening now');
    }
  }
}
