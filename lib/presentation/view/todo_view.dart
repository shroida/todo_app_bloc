import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/domain/repository/todo_repo.dart';
import 'package:todo_app_bloc/presentation/todo_cubit.dart';
import 'package:todo_app_bloc/presentation/view/widgets/TodoViewScreen.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key, required this.todoRepo});
  final TodoRepo todoRepo;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepo),
      child: const TodoViewScreen(),
    );
  }
}
