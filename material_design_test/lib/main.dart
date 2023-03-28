import 'package:flutter/material.dart';

import 'asset_test.dart';

void main() {
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
        home: const AssetTest(title: 'Material Design Asset Test'),
//      home: const MaterialMain(title: 'Material Design Test Main'),
    );
  }
}


class MaterialMain extends StatefulWidget {
  const MaterialMain({super.key, required this.title});
  final String title;

  @override
  State<MaterialMain> createState() => _MaterialMain();
}


class _MaterialMain extends State<MaterialMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

        },
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.android),
              Text("Android"),
            ],
          ),
        )
      ),
    );
  }
}
