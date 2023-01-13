import 'package:build_cli_annotations/build_cli_annotations.dart';

part 'create_admin_params.g.dart';

@CliOptions()
class CreateAdminUserParams {
  @CliOption(help: 'The username of the administrator.')
  final String username;

  @CliOption(help: 'The password of the administrator.')
  final String password;

  CreateAdminUserParams(this.username, this.password);
}

String get usage => _$parserForCreateAdminUserParams.usage;

ArgParser populateCreateAdminUserParamsParser(ArgParser p) => _$populateCreateAdminUserParamsParser(p);

CreateAdminUserParams parseCreateAdminUserParamsResult(ArgResults results) => _$parseCreateAdminUserParamsResult(results);
