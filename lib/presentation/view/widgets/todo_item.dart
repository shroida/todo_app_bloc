import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/domain/data/models/todo.dart';
import 'package:todo_app_bloc/presentation/todo_cubit.dart';
import 'package:todo_app_bloc/presentation/view/widgets/show_update_dialog.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});
  final Todo todo;

  void _showDeleteConfirmationDialog(BuildContext context) {
    final TodoCubit todoCubit = context.read<TodoCubit>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: const Text('Are you sure you want to delete this todo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
               todoCubit.deleteTodo(todo);
                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(BuildContext context) {
    final textController = TextEditingController(text: todo.text);
    final TodoCubit todoCubit = context.read<TodoCubit>();
    showDialog(
      context: context,
      builder: (context) {
        return DialogToUpdate(
          textController: textController,
          todo: todo,
          todoCubit: todoCubit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: todo.isCompleted,
          onChanged: (value) {
            context.read<TodoCubit>().toggleCompletation(todo);
          },
        ),
        Expanded(
          child: GestureDetector(
            onLongPress: () {
              _showDeleteConfirmationDialog(context);
            },
            onTap: () => _showUpdateDialog(context),
            child: Text(
              todo.text,
              style: TextStyle(
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
