import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton pattern to ensure only one instance of the database is used
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  // Private constructor to prevent external instantiation
  DatabaseHelper._privateConstructor();

  // Getter for the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDb();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initializeDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo_app.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create the 'todos' table
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY,
            text TEXT,
            isCompleted INTEGER
          )
        ''');
      },
    );
  }

  // CRUD operations
  Future<int> insertTodo(Map<String, dynamic> todo) async {
    final db = await database;
    return await db.insert('todos', todo);
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await database;
    return await db.query('todos');
  }

  Future<int> updateTodo(Map<String, dynamic> todo) async {
    final db = await database;
    return await db.update(
      'todos',
      todo,
      where: 'id = ?',
      whereArgs: [todo['id']],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
