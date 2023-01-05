import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:args/command_runner.dart';
import 'package:flutter_todo/cli/create_admin_params.dart';
import 'package:flutter_todo/realm/schemas.dart';
import 'package:realm/realm.dart';

class CreateAdminUserCommand extends Command<void> {
  @override
  final String description = 'Creates a new user with administrative permissions.';

  @override
  final String name = 'create-admin';

  late CreateAdminUserParams parameters;

  CreateAdminUserCommand() {
    populateCreateAdminUserParamsParser(argParser);
  }

  @override
  FutureOr<void>? run() async {
    print("run CreateAdminUserCommand");
    parameters = parseCreateAdminUserParamsResult(argResults!);
    print("username: ${parameters.username}, password: ${parameters.password}");
    await registerAdmin(parameters.username, parameters.password);
  }

  Future<void> registerAdmin(String email, String password) async {
    final realmConfig = json.decode(await File('assets/atlas_app/realm_config.json').readAsString());
    String appId = realmConfig['app_id'];
    final app = App(AppConfiguration(appId));
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    await authProvider.registerUser(email, password);
    User loggedInUser = await app.logIn(Credentials.emailPassword(email, password));

    final realm = Realm(Configuration.flexibleSync(loggedInUser, [Role.schema, Item.schema]));
    realm.subscriptions.update((mutableSubscriptions) => mutableSubscriptions.add(realm.all<Role>()));
    await realm.subscriptions.waitForSynchronization();
    realm.write(() => realm.add(Role(ObjectId(), loggedInUser.id, isAdmin: true)));
    await realm.syncSession.waitForUpload();
    await loggedInUser.logOut();
    realm.close();
  }

  void abort(String error) {
    print(error);
    print(usage);
    exit(64);
  }
}
