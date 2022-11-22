import 'package:realm_dart/realm.dart';

import '../settings.dart';
import 'base.dart';

class LogOutCommand extends CommandBase {
  LogOutCommand() : super('logout', 'Log out user, if any is currently logged in');

  @override
  Future<void> runWithRealm(Realm realm) async {
    // Get user (should already be logged in)
    final appId = Settings.appId.value;
    final baseUrl = Uri.parse(Settings.baseUrl.value);
    final app = App(AppConfiguration(appId, baseUrl: baseUrl, baseFilePath: basePath));
    await app.currentUser!.logOut();
  }
}
