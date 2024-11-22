import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/presentation/todo_cubit.dart';
import 'package:todo_app_bloc/domain/data/models/todo.dart';
import 'package:todo_app_bloc/presentation/view/widgets/floating_button_container.dart';
import 'package:todo_app_bloc/presentation/view/widgets/show_add_dialog.dart';
import 'package:todo_app_bloc/presentation/view/widgets/todo_item.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return DialogToAdd(
            textController: textController, todoCubit: todoCubit);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TodoCubit, List<Todo>>(
          builder: (context, todos) {
            return Text('Todo Count: ${todoCubit.todoCount}');
          },
        ),
      ),
      floatingActionButton: FloatingButtonContainer(
        callbackFunction: _showAddTodoBox,
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Container(
                height: 100,
                decoration: boxDecoration(),
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 16.0),
                margin: const EdgeInsets.all(5),
                child: TodoItem(todo: todo),
              );
            },
          );
        },
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(3, 3),
        ),
      ],
    );
  }
}
