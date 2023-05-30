import 'package:flutter/material.dart';
import 'package:todo_list_sqllite/model/todo.dart';
import 'package:todo_list_sqllite/util/todo_sqllite_database_provider.dart';

class MaterialMain extends StatefulWidget {
  final String title;
  final TodoSQLiteDatabaseProvider databaseProvider;

  const MaterialMain({super.key, required this.title, required this.databaseProvider});

  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> {
  Future<List<Todo>>? todoList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: todoList,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if(snapshot.hasData){
                  return ListView.separated(
                    itemCount: (snapshot.data as List<Todo>).length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        color: Colors.blueGrey,
                      );
                    },
                    itemBuilder: (context, index) {

                    }
                  );
                } else {
                  return Text("Empty Data");
                }
              } else {
                return Text("ConnectionState: ${snapshot.connectionState}");
              }
            },
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _createTodo();
        },
      ),
    );
  }

  Future<void> _createTodo() async {
    Todo todo = Navigator.of(context).pushNamed('/create') as Todo;
    widget.databaseProvider.inserTodo(todo);
  }
}