import 'package:realm_dart/realm.dart';

import '../settings.dart';
import 'base.dart';

class LogInCommand extends CommandBase {
  static const appIdOption = 'appId';
  static const baseUrlOption = 'baseUrl';
  static const emailOption = 'email';
  static const passwordOption = 'password';

  LogInCommand() : super('login', 'log in to MongoDB Atlas App Service') {
    argParser
      ..addOption(appIdOption, abbr: appIdOption[0], help: 'the realm application id on MongoDB Atlas')
      ..addOption(baseUrlOption, abbr: baseUrlOption[0], help: 'Base URL to contact server', defaultsTo: 'https://realm.mongodb.com')
      ..addOption(emailOption, abbr: emailOption[0], help: 'email of user')
      ..addOption(passwordOption, abbr: passwordOption[0], help: 'password of user');
  }

  @override
  Future<void> runWithRealm(Realm realm) async {
    final appId = argResults![appIdOption] as String;
    final baseUrl = Uri.tryParse(argResults![baseUrlOption]);
    final email = argResults![emailOption] as String;
    final password = argResults![passwordOption] as String;

    final app = App(AppConfiguration(appId, baseUrl: baseUrl, baseFilePath: basePath));
    final credentials = Credentials.emailPassword(email, password);

    Realm.logger.info('log in');
    await app.logIn(credentials);
    Realm.logger.info('log in done!');

    // Update settings
    Settings.appId.value = appId;
    Settings.baseUrl.value = baseUrl.toString();

    Realm.logger.info('command done!');
  }
}
