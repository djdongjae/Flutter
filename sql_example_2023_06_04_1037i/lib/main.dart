import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DatabaseApp(),
    );
  }
}

class DatabaseApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Database Example'),),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final todo = await Na
        },
      ),
    );
  }
}
