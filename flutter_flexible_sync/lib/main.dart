import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import 'model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final realmConfig = json.decode(await rootBundle.loadString('assets/atlas_app/realm_config.json'));
  String appId = realmConfig['app_id'];
  MyApp.allTasksRealm = await createRealm(appId, CollectionType.allTasks);
  MyApp.importantTasksRealm = await createRealm(appId, CollectionType.importantTasks);
  MyApp.normalTasksRealm = await createRealm(appId, CollectionType.normalTasks);

  runApp(const MyApp());
}

enum CollectionType { allTasks, importantTasks, normalTasks }

Future<Realm> createRealm(String appId, CollectionType collectionType) async {
  final appConfig = AppConfiguration(appId);
  final app = App(appConfig);
  final user = await app.logIn(Credentials.anonymous());

  final flxConfig = Configuration.flexibleSync(user, [Task.schema], path: await absolutePath("db_${collectionType.name}.realm"));
  var realm = Realm(flxConfig);
  print("Created local realm db at: ${realm.config.path}");

  final RealmResults<Task> query;

  if (collectionType == CollectionType.allTasks) {
    query = realm.all<Task>();
  } else {
    query = realm.query<Task>(r'isImportant == $0', [collectionType == CollectionType.importantTasks]);
  }

  realm.subscriptions.update((mutableSubscriptions) {
    mutableSubscriptions.add(query);
  });

  await realm.subscriptions.waitForSynchronization();
  await realm.syncSession.waitForDownload();
  print("Syncronization completed for realm: ${realm.config.path}");
  return realm;
}

Future<String> absolutePath(String fileName) async {
  final appDocsDirectory = await getApplicationDocumentsDirectory();
  final realmDirectory = '${appDocsDirectory.path}/mongodb-realm';
  if (!Directory(realmDirectory).existsSync()) {
    await Directory(realmDirectory).create(recursive: true);
  }
  return "$realmDirectory/$fileName";
}

class MyApp extends StatelessWidget {
  static late Realm allTasksRealm;
  static late Realm importantTasksRealm;
  static late Realm normalTasksRealm;

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Realm Flexible Sync'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _allTasksCount = MyApp.allTasksRealm.all<Task>().length;
  int _importantTasksCount = MyApp.importantTasksRealm.all<Task>().length;
  int _normalTasksCount = MyApp.normalTasksRealm.all<Task>().length;

  void _createImportantTasks() async {
    var importantTasks = MyApp.importantTasksRealm.all<Task>();
    var allTasksCount = MyApp.allTasksRealm.all<Task>();
    MyApp.allTasksRealm.write(() {
      MyApp.allTasksRealm.add(Task(ObjectId(), "Important task ${importantTasks.length + 1}", false, true));
    });
    await MyApp.allTasksRealm.syncSession.waitForUpload();
    await MyApp.importantTasksRealm.subscriptions.waitForSynchronization();
    setState(() {
      _importantTasksCount = importantTasks.length;
      _allTasksCount = allTasksCount.length;
    });
  }

  void _createNormalTasks() async {
    var normalTasks = MyApp.normalTasksRealm.all<Task>();
    var allTasksCount = MyApp.allTasksRealm.all<Task>();
    MyApp.allTasksRealm.write(() {
      MyApp.allTasksRealm.add(Task(ObjectId(), "Normal task ${normalTasks.length + 1}", false, false));
    });
    await MyApp.allTasksRealm.syncSession.waitForUpload();
    await MyApp.normalTasksRealm.subscriptions.waitForSynchronization();
    setState(() {
      _normalTasksCount = normalTasks.length;
      _allTasksCount = allTasksCount.length;
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
              const Text('Important tasks count:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$_importantTasksCount', style: Theme.of(context).textTheme.headline4),
              const Text('Normal tasks count:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$_normalTasksCount', style: Theme.of(context).textTheme.headline4),
              const Text('All tasks count:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$_allTasksCount', style: Theme.of(context).textTheme.headline4),
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: _createImportantTasks,
                    tooltip: 'High priority task',
                    child: const Icon(Icons.add),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: _createNormalTasks,
                    tooltip: 'Normal task',
                    child: const Icon(Icons.add),
                  )),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat);
  }
}
