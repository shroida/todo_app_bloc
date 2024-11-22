import 'package:todo_app_bloc/domain/data/models/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getTodos();
  
  Future<void> addNewTodo(Todo newTodo);

  Future<void> deleteTodo(Todo todo);
  
  Future<void> updateTodo(Todo todo);
}