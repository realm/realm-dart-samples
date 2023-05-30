import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:flutter_todo/cli/create_admin_cmd.dart';

void main(List<String> arguments) async {
  if (arguments.isNotEmpty) {
    print(arguments.join(","));
    CommandRunner<void>("dart run", 'Helper commands for running samples.')
      ..addCommand(CreateAdminUserCommand())
      ..run(arguments).then((value) => exit(0)).catchError((Object error) {
        if (error is UsageException) {
          print(error);
          exit(64); // Exit code 64 indicates a usage error.
        }
        throw error;
      });
  }
}
