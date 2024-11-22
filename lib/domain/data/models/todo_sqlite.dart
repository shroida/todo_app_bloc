import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app_bloc/domain/data/models/todo.dart';

class TodoSQLite {
  static const String tableName = 'todos';

  late int id;
  late String text;
  late bool isCompleted;

  TodoSQLite({this.id = 0, required this.text, required this.isCompleted});

  Todo toDomain() {
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  static TodoSQLite fromDomain(Todo todo) {
    return TodoSQLite(
        id: todo.id, text: todo.text, isCompleted: todo.isCompleted);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  static TodoSQLite fromMap(Map<String, dynamic> map) {
    return TodoSQLite(
      id: map['id'],
      text: map['text'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  // Database methods
  static Future<Database> initializeDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo_app.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            text TEXT NOT NULL,
            isCompleted INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  static Future<int> insertTodo(Database db, TodoSQLite todo) async {
    return await db.insert(tableName, todo.toMap());
  }

  static Future<List<TodoSQLite>> fetchTodos(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) => TodoSQLite.fromMap(maps[i]));
  }

  static Future<int> updateTodo(Database db, TodoSQLite todo) async {
    return await db.update(
      tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  static Future<int> deleteTodo(Database db, int id) async {
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
