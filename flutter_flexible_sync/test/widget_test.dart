// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flexible_sync/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as _path;
import 'package:realm/realm.dart';

void main() {
  setUp(() async {
    final path = _path.join(Directory.systemTemp.createTempSync("realm_test_").path, "default_tests.realm");
    Configuration.defaultRealmPath = path;
    await initRealm();
    addTearDown(() async {
      Realm.deleteRealm(path);
    });
  });
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
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
