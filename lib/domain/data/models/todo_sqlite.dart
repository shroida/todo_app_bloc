import 'package:todo_app_bloc/domain/data/models/todo.dart';

class TodoSQLite {
  late int id;
  late String text;
  late bool isCompleted;

  TodoSQLite({this.id = 0, required this.text, required this.isCompleted});

  // Convert a TodoSQLite instance to a domain Todo
  Todo toDomain() {
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  // Convert a domain Todo to a TodoSQLite instance
  static TodoSQLite fromDomain(Todo todo) {
    return TodoSQLite(
        id: todo.id, text: todo.text, isCompleted: todo.isCompleted);
  }

 
}
