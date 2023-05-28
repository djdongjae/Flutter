import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoSQLiteDatabaseProvider {
  static const String DATABASE_FILENAME = "todo_database.db";
  static const String TODOS_TABLENAME = "todos";

  static TodoSQLiteDatabaseProvider databaseProvider = TodoSQLiteDatabaseProvider._();
  static Database? database;

  TodoSQLiteDatabaseProvider._();

  static TodoSQLiteDatabaseProvider getDatabaseProvider() => databaseProvider;

  Future<Database> getDatabase() async {
    return database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), DATABASE_FILENAME),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $TODOS_TABLENAME(id INTEGER PRIMARY AUTOINCREMENT, title TEXT, content TEXT, hasFinished INTEGER)'
        );
      }
    );
  }

}