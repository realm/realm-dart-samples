import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:flutter/services.dart';
import 'model.dart';

late Realm realm;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  realm = await initRealm("realm/initial.realm");
  runApp(const MyApp());
}

Future<Realm> initRealm(String assetKey) async {
  final config = Configuration.local([Car.schema]);
  final file = File(config.path);
  // await file.delete(); // <-- uncomment this to start over on every restart
  if (!await file.exists()) {
    ByteData realmBytes = await rootBundle.load(assetKey);
    await file.writeAsBytes(
      realmBytes.buffer.asUint8List(realmBytes.offsetInBytes, realmBytes.lengthInBytes),
      mode: FileMode.write,
    );
  }
  return Realm(config);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _addRandomCar() {
    const cars = ['Mercedes', 'VW', 'Ford', 'Tesla', 'Ferrari', 'Polestar', 'Volvo', 'BMW'];
    final r = Random();

    realm.write(() {
      realm.add(
        Car(
          cars[r.nextInt(cars.length)],
          model: '${r.nextInt(20) + 2002}',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _addRandomCar,
          tooltip: 'Add a car',
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<RealmResultsChanges<Car>>(
          stream: realm.all<Car>().changes,
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (data == null) return const CircularProgressIndicator();

            final results = data.results;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final c = results[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.car_rental)),
                  title: Text(c.make),
                  subtitle: Text(c.model ?? ''),
                );
              },
            );
          },
        ),
      ),
    );
    // home: const MyHomePage(title: 'Flutter Demo Home Page'));
  }
}
