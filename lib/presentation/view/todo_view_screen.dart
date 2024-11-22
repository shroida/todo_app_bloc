
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/domain/data/models/database_helper.dart';
import 'package:todo_app_bloc/presentation/todo_cubit.dart';
import 'package:todo_app_bloc/presentation/view/widgets/todo_view.dart';

import '../../domain/data/todo_repo_impl.dart';

class TodoViewScreen extends StatelessWidget {
  const TodoViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dbHelper = DatabaseHelper.instance;
        final todoRepo = TodoRepoImpl(dbHelper);
        return TodoCubit(todoRepo)..loadTodos();
      },
      child: const TodoView(),
    );
  }
}
