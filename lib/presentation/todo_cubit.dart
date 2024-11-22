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
    emit(todoList);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        isCompleted: false,
        text: text);
    await todoRepo.addNewTodo(newTodo);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await todoRepo.updateTodo(todo);
    loadTodos();
  }

  Future<void> toggleCompletation(Todo todo) async {
    todo.toggleCompletion();
  }
}
