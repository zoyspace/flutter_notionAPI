import 'package:flutter/material.dart';
import 'models/NotionAPI.dart';
import 'widgets/widgetProperties.dart';
import 'widgets/widgetStatful.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GlobalData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'notion API'),
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
  int _counter = 0;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    for (int i = 0; i < myTextController.length; i++) {
      myTextController[i].dispose();
    }

    notionTokenController.dispose();
    dbIDController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    NotionAPI().getData();
    notionTokenController.text = 'totototo';
  }

  void _incrementCounter() async {
    _counter++;
    setState(() {});
  }

  void _getDBproperties() async {
    await NotionAPI().getDatabase();
    await NotionAPI().setData();
    setState(() {});
  }

  void _upDBproperties() async {
    await NotionAPI().getDatabase();
    await NotionAPI().setData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TextFormField(
              //token
              controller: notionTokenController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Token'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                //DBID
                controller: dbIDController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'DataBase ID')),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton(
                onPressed: _getDBproperties,
                tooltip: 'getDBproperties',
                child: Container(child: const Text('Get'))),
            Column(
              children: [
                Text(DateTime.now().toString()),
                Text(getStatusMessage),
              ],
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            for (int i = 0; i < myTextController.length; i++)
              widgetProperties(i),
            FloatingActionButton(
                onPressed: _upDBproperties,
                tooltip: 'upDBproperties',
                child: Container(child: const Text('Upload'))),
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
