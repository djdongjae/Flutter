import 'package:flutter/material.dart';
import 'package:todo_list/todo_create.dart';
import 'package:todo_list/todo_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String TITLE_APP = "My App";

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),

        routes: {
          '/': (context) => MyHomePage(title: "$TITLE_APP for Android"),
          '/detail': (context) => TodoDetail(title: "TodoDetail for Android"),
          '/create': (context) => TodoCreate(title: "TodoCreate for Android"),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  List<String> todoList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.separated(
          itemCount: todoList.length,
          separatorBuilder: (context, index) {
            return const Divider(
              height: 2,
              color: Colors.blueGrey
            );
          },
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                child: Text(todoList[index], style: TextStyle(fontSize: 20),),
                onTap: () {
                  Navigator.of(context).pushNamed('/detail', arguments: todoList[index]);
                },
              ),
            );
          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initstate() {
    super.initState();

    todoList.add("Flutter 공부하기");
    todoList.add("운동하기");
  }
}
