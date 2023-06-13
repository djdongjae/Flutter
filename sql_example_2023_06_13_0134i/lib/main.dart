import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'todo.dart';
import 'addTodo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(database),
        '/add': (context) => AddTodoApp(database)
      },
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), 'todo_database.db'),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, active INTEGER)");
        }, version: 1);
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  DatabaseApp(this.db);

  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {
  Future<List<Todo>>? todoList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo 리스트'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Todo todo = (snapshot.data as List<Todo>)[index];
                        return ListTile(
                          title: Text(
                            todo.title!,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Container(
                            child: Column(
                              children: <Widget>[
                                Text(todo.content!),
                                Text('체크 : ${todo.active == 1 ? '완료' : '미완료'}'),
                                Container(
                                  height: 1,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            TextEditingController controller =
                            new TextEditingController(text: todo.content);
                            bool isChecked = (todo.active == 1) ? true : false;

                            Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Container(
                                          child: Column(
                                            children: <Widget>[
                                              TextField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                    labelText: "할일"),
                                              ),
                                              CheckboxListTile(
                                                title: Text('완료 여부'),
                                                value: isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value!;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          todo.active = isChecked ? 1 : 0;
                                          todo.content = controller.value.text;
                                          Navigator.of(context).pop(todo);
                                        },
                                        child: Text('수정'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(todo);
                                        },
                                        child: Text('취소'),
                                      ),
                                    ],
                                  );
                                });
                            _updateTodo(result);
                          },
                          onLongPress: () async {
                            Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content:
                                    Text('할일 <${todo.content}>를 삭제하시겠습니까?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(todo);
                                        },
                                        child: Text('예'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('아니요'),
                                      ),
                                    ],
                                  );
                                });
                            _deleteTodo(result);
                          },
                        );
                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  } else {
                    return Text('No data');
                  }
              }
            },
            future: todoList,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.of(context).pushNamed('/add');
          if (todo != null) {
            _insertTodo(todo as Todo);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');
    return List.generate(maps.length, (i) {
      int active = maps[i]['active'] == 1 ? 1 : 0;
      return Todo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          active: active,
          id: maps[i]['id']
      );
    });
  }

  void _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.insert(
        'todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update(
      'todos', todo.toMap(), where: 'id=?', whereArgs: [todo.id]
    );
    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete(
        'todos', where: 'id=?', whereArgs: [todo.id]
    );
    setState(() {
      todoList = getTodos();
    });
  }

}
