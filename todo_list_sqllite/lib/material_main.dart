import 'package:flutter/material.dart';
import 'package:todo_list_sqllite/model/todo.dart';
import 'package:todo_list_sqllite/util/todo_sqllite_database_provider.dart';

class MaterialMain extends StatefulWidget {
  final String title;
  final TodoSQLiteDatabaseProvider databaseProvider;

  const MaterialMain(
      {super.key, required this.title, required this.databaseProvider});

  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> {
  Future<List<Todo>>? todoList;

  @override
  void initState() {
    super.initState();
    todoList = _getTodos();
  }

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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                        itemCount: (snapshot.data as List<Todo>).length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 1,
                            color: Colors.blueGrey,
                          );
                        },
                        itemBuilder: (context, index) {
                          Todo todo = (snapshot.data as List<Todo>)[index];
                          return ListTile(
                            title: Text(
                              todo.title!, style: TextStyle(fontSize: 16),),
                            subtitle: Column(
                              children: <Widget>[
                                Text(todo.content!),
                                Text(todo.hasFinished == 1 ? "완료" : "미완료"),
                              ],
                            ),
                            onTap: () {
                              _updateTodo(todo);
                            },
                          );
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
    await widget.databaseProvider.inserTodo(todo);
    setState(() {
      todoList = _getTodos();
    });
  }

  Future<List<Todo>> _getTodos() {
    return widget.databaseProvider.getTodos();
  }

  Future<void> _updateTodo(Todo todo) async {
    var resTodo = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${todo.id}: ${todo.title}"),
            content: CheckboxListTile(
              title: Text("완료 여부"),
              value: (todo.hasFinished == 1)? true: false,
              onChanged: (bool? value) {
                setState(() {
                  todo.hasFinished = value!? 1: 0;
                });
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text("수정"),
                onPressed: () {
                  Navigator.of(context).pop(todo);
                },
              )
            ],
          );
        }
    );
  }
}