import 'package:class_flutter_1_todo/core/dependencies/dependency.dart';
import 'package:class_flutter_1_todo/features/todo/presentation/blocs/todo_bloc.dart';
import 'package:class_flutter_1_todo/features/todo/presentation/pages/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initDependency();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => di<TodoBloc>(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}
