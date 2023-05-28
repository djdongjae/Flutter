import 'package:flutter/material.dart';
import 'package:todo_list_sqllite/util/todo_sqllite_database_provider.dart';

class MaterialMain extends StatefulWidget {
  final String title;
  final TodoSQLiteDatabaseProvider databaseProvider;

  const MaterialMain({super.key, required this.title, required this.databaseProvider});

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
      body: Container(

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _createTodo();
        },
      ),
    );
  }

  void _createTodo() {

  }
}