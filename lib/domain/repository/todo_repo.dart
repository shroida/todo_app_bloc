import 'package:todo_app_bloc/domain/models/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getTodos();
  
}