import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

Future<void> copyAsset(BuildContext context, String assetKey, String path) async {
  var assets = DefaultAssetBundle.of(context);
  final byteData = await assets.load(assetKey);
  final file = File(path);
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes), mode: FileMode.write);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<String> carsList = [];
  String text = "";

  void _incrementCars() {
    //In realm 0.3.2+beta use the static member Configuration.defaultRealmPath instead Configuration.local([Car.schema]).path;
    final defaultRealmPathConfig = Configuration.local([Car.schema]).path;
    final config = Configuration.local([Car.schema], initialDataCallback: (realm) async {
      await copyAsset(context, "realm/initial.realm", defaultRealmPathConfig);
    });

    setState(() {
      final realm = Realm(config);
      realm.write(() => realm.add(Car("New make", model: "${carsList.length + 1}")));
      text = getCarsList(realm);
    });
  }

  String getCarsList(Realm realm) {
    carsList.clear();
    var cars = realm.all<Car>();
    for (var car in cars) {
      carsList.add("Car:${car.make},${car.model}");
    }
    return carsList.join("\n");
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
              text,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCars,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
