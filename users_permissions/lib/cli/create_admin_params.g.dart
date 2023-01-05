// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_admin_params.dart';

// **************************************************************************
// CliGenerator
// **************************************************************************

CreateAdminUserParams _$parseCreateAdminUserParamsResult(ArgResults result) =>
    CreateAdminUserParams(
      result['username'] as String,
      result['password'] as String,
    );

ArgParser _$populateCreateAdminUserParamsParser(ArgParser parser) => parser
  ..addOption(
    'username',
    help: 'The username of the administrator.',
  )
  ..addOption(
    'password',
    help: 'The password of the administrator.',
  );

final _$parserForCreateAdminUserParams =
    _$populateCreateAdminUserParamsParser(ArgParser());

CreateAdminUserParams parseCreateAdminUserParams(List<String> args) {
  final result = _$parserForCreateAdminUserParams.parse(args);
  return _$parseCreateAdminUserParamsResult(result);
}
