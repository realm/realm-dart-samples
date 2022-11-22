import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:realm_dart/realm.dart';
import 'package:time_track_cli/src/commands/base.dart';
import 'package:time_track_cli/src/commands/move.dart';

import 'src/commands/clear.dart';
import 'src/commands/login.dart';
import 'src/commands/logout.dart';
import 'src/commands/now.dart';
import 'src/commands/show.dart';
import 'src/commands/sync.dart';
import 'src/commands/watch.dart';

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
    ..addCommand(MoveCommand())
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

  try {
    await runner.run(arguments);
    exit(0);
  } catch (error) {
    if (error is! UsageException) rethrow;
    print(error);
    exit(64); // Exit code 64 indicates a usage error.
  } finally {
    Realm.shutdown();
  }
}
