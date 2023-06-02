import 'package:flutter/material.dart';
import 'package:todo_list_sqllite/todo_create.dart';
import 'package:todo_list_sqllite/util/todo_sqllite_database_provider.dart';
import 'material_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String TITLE_APP = "My App";

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TodoSQLiteDatabaseProvider databaseProvider = TodoSQLiteDatabaseProvider.getDatabaseProvider();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: '/',
      routes: {
        '/' : (context) => MaterialMain(title: "$TITLE_APP for Android", databaseProvider: databaseProvider),
        '/create' : (context) => TodoCreate(title: "$TITLE_APP for Android",),
//        '/finished' : (context) => TodoFinished(title: "$TITLE_APP for Android",),
      },
    );
  }
}

