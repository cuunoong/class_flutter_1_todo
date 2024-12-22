import 'package:class_flutter_1_todo/features/todo/domain/entities/todo.dart';
import 'package:class_flutter_1_todo/features/todo/presentation/blocs/todo_bloc.dart';
import 'package:class_flutter_1_todo/features/todo/presentation/widgets/create_todo_widget.dart';
import 'package:class_flutter_1_todo/features/todo/presentation/widgets/todo_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  static const String routeName = '/todo';

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Todo> todos = [];
  late TodoBloc _todoBloc;

  @override
  void initState() {
    _todoBloc = context.read<TodoBloc>();
    _todoBloc.add(GetTodosEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is FailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          return;
        }

        if (state is! SuccessState) return;

        switch (state.type) {
          case Type.get:
            todos.clear();
            todos.addAll(state.data);

            _listKey.currentState?.insertAllItems(0, state.data.length);

            break;

          case Type.add:
            todos.insert(0, state.data);
            _listKey.currentState?.insertItem(0);
            break;
          default:
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFECEEEF),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: Column(
              spacing: 16,
              children: [
                CreateTodoWidget(
                  onSubmitted: (newTodo) {
                    _todoBloc.add(AddTodoEvent(newTodo));
                  },
                ),
                Flexible(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: todos.length,
                    itemBuilder: (context, index, animation) {
                      final todo = todos[index];
                      return TodoItemWidget(
                        todo: todo.todo,
                        animation: animation,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
