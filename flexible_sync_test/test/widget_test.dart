// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flexible_sync_test/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as _path;
import 'package:flexible_sync_test/main.dart';
import 'package:realm/realm.dart';

void main() {
  setUp(() {
    print(Platform.environment['FLUTTER_TEST']);
    _printPlatformInfo();
    final path = _path.join(Directory.systemTemp.createTempSync("realm_test_").path, "default_tests.realm");
    Configuration.defaultRealmPath = path;
  });

  testWidgets('local Realm', (WidgetTester tester) async {
    final localConfig = Configuration.local([Task.schema]);
    print(localConfig.path);
    print(Directory.current.absolute.path);
    var realm = Realm(localConfig);
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('flexibleSync Realm', (WidgetTester tester) async {
    Realm.logger.level = RealmLogLevel.all;
    final realmConfig = json.decode(await rootBundle.loadString('assets/atlas_app/realm_config.json'));
    String appId = realmConfig['app_id'];
    print(Directory.current.absolute.path);

    final appConfig = AppConfiguration(appId);
    print(appConfig.baseFilePath);
    print(appConfig.baseUrl);
    final app = App(appConfig);
    final user = await app.logIn(Credentials.anonymous(reuseCredentials: false));
    final flxConfig = Configuration.flexibleSync(user, [Task.schema]);
    print(flxConfig.path);
    var realm = Realm(flxConfig);
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

Future<void> _printPlatformInfo() async {
  final pointerSize = sizeOf<IntPtr>() * 8;
  final os = Platform.operatingSystem;
  String? cpu;

  if (!isFlutterPlatform) {
    if (Platform.isWindows) {
      cpu = Platform.environment['PROCESSOR_ARCHITECTURE'];
    } else {
      final info = await Process.run('uname', ['-m']);
      cpu = info.stdout.toString().replaceAll('\n', '');
    }
  }

  print('Current PID $pid; OS $os, $pointerSize bit, CPU ${cpu ?? 'unknown'}');
}
