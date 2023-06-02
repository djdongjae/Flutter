import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_sqllite/model/todo.dart';

class TodoSQLiteDatabaseProvider {
  static const String DATABASE_FILENAME = "todo_database.db";
  static const String TODOS_TABLENAME = "todos";

  static TodoSQLiteDatabaseProvider databaseProvider = TodoSQLiteDatabaseProvider._();
  static Database? _database;

  TodoSQLiteDatabaseProvider._();

  static TodoSQLiteDatabaseProvider getDatabaseProvider() => databaseProvider;

  Future<Database> _getDatabase() async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), DATABASE_FILENAME),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $TODOS_TABLENAME(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, hasFinished INTEGER)'
        );
      }
    );
  }

  Future<void> inserTodo(Todo todo) async {
    Database database = await _getDatabase();
    database.insert(TODOS_TABLENAME, todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todo>> getTodos() async {
    Database database = await _getDatabase();
    var maps = await database.query(TODOS_TABLENAME);

    List<Todo> todoList = List.empty(growable: true);
    for(Map<String, dynamic> map in maps) {
      todoList.add(Todo.fromMap(map));
    }

    return todoList;
  }
}