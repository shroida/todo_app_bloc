import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_bloc/domain/data/models/database_helper.dart';
import 'package:todo_app_bloc/domain/data/models/todo.dart';
import 'package:todo_app_bloc/domain/repository/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  // Initialize the database
  final DatabaseHelper dbHelper;
  TodoRepoImpl(this.dbHelper);

  static Future<Database> _initializeDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo_app.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, text TEXT, isCompleted INTEGER)',
        );
      },
    );
  }

  // Add a new Todo
  @override
  Future<void> addNewTodo(Todo newTodo) async {
    final db = await _initializeDb();
    await db.insert(
      'todos',
      {
        'text': newTodo.text,
        'isCompleted': newTodo.isCompleted ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Delete a Todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    final db = await _initializeDb();
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Get all Todos
  @override
  Future<List<Todo>> getTodos() async {
    final db = await _initializeDb();
    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        text: maps[i]['text'],
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }

  // Update a Todo
  @override
  Future<void> updateTodo(Todo todo) async {
    final db = await _initializeDb();
    await db.update(
      'todos',
      {
        'text': todo.text,
        'isCompleted': todo.isCompleted ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }
}
