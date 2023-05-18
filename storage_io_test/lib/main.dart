import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You have pushed this button this many times"),
              Text("$counter",
                  style: Theme.of(context).textTheme.headlineMedium)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _increaseCounter,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadIntFromSharedPreferences("counter").then(
        (value) {
          setState(() {
            counter = value;
          });
        }
    );
  }

  void _increaseCounter() {
    setState(() {
      counter++;
    });
    _saveIntToSharedPreferences("counter", counter);
  }

  Future<void> _saveIntToSharedPreferences(String key, int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(key, value);
  }

/*Future<void> _loadIntFromSharedPreferences(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      counter = sharedPreferences.getInt(key) ?? 0;
    });
  }*/

  Future<int> _loadIntFromSharedPreferences(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }
}
