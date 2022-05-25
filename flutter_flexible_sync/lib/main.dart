import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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
  int _importantTasksCount = 0;
  int _normalTasksCount = 0;

  void _createImportantTasks() {
    setState(() {
      _importantTasksCount++;
    });
  }

  void _createNormalTasks() {
    setState(() {
      _normalTasksCount++;
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
                'Important tasks count:',
              ),
              Text(
                '$_importantTasksCount',
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text(
                'Normal tasks count:',
              ),
              Text(
                '$_normalTasksCount',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: _createImportantTasks,
                    tooltip: 'High priority task',
                    child: const Icon(Icons.add),
                  )),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _createNormalTasks,
                  tooltip: 'Normal task',
                  child: const Icon(Icons.add),
                )),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat);
  }
}
