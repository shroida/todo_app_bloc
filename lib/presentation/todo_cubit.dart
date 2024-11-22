import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/domain/data/models/todo.dart';
import 'package:todo_app_bloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodos();
  }
}
