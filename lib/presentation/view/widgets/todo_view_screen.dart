import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/presentation/todo_cubit.dart';

class TodoViewScreen extends StatelessWidget {
  const TodoViewScreen({super.key});
  // Method to show the dialog for adding a new Todo
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>(); // Access the Cubit
    final textController = TextEditingController(); // Controller for text input

    // Show dialog for adding a Todo
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Enter todo text'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the Todo and close the dialog
                final todoText = textController.text;
                if (todoText.isNotEmpty) {
                  todoCubit.addTodo(
                      todoText); // Call the cubit method to add the todo
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), onPressed: () => _showAddTodoBox),
    );
  }
}
