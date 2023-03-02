import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm/realm.dart';
import 'package:path/path.dart' as _path;

import 'model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  printPlatformInfo();
  //final path = _path.join(Directory.systemTemp.createTempSync("realm_test_").path, "default_tests.realm");
  //Configuration.defaultRealmPath = path;

  print("Directory.current.absolute.path: ${Directory.current.absolute.path}");

  print("Configuration.defaultRealmPath: ${Configuration.defaultRealmPath}");

  print("Platform.environment['FLUTTER_TEST']: ${Platform.environment['FLUTTER_TEST']}");

  Realm.logger.level = RealmLogLevel.all;
  final realmConfig = json.decode(await rootBundle.loadString('assets/atlas_app/realm_config.json'));
  String appId = realmConfig['app_id'];

  final appConfig = AppConfiguration(appId);
  final app = App(appConfig);

  print("appConfig.baseUrl: ${appConfig.baseUrl}");
  print("appConfig.baseFilePath: ${appConfig.baseFilePath}");
 
  final user = await app.logIn(Credentials.anonymous(reuseCredentials: false));
  final flxConfig = Configuration.flexibleSync(user, [Task.schema]);
  print("flxConfig.path: ${flxConfig.path}");
  var realm = Realm(flxConfig);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<void> printPlatformInfo() async {
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
