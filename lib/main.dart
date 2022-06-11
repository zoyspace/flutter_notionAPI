import 'package:flutter/material.dart';
import 'models/NotionAPI.dart';
import 'widgets/widgetProperties.dart';
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  var _result = '';

  @override
  void initState() {
    super.initState();
    NotionAPI().getData();
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await NotionAPI().getDatabase();
    await NotionAPI().setData();
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            for (int i = 0; i < dbNameList.length; i++)
              widgetProperties(dbNameList[i], dbTypeList[i]),
            // showProperties(dbNameList[0], dbTypeList[0]),
            // showProperties(dbNameList[1], dbTypeList[1]),
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
