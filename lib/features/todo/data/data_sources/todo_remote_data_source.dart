import 'package:class_flutter_1_todo/features/todo/data/models/todo_model.dart';

abstract interface class TodoRemoteDataSource {
  Future<TodoModel> addTodo({
    required String todo,
  });

  Future<TodoModel> updateTodo({
    required String id,
    String? todo,
    bool? isChecked,
  });

  Future<void> deleteTodo({
    required String id,
  });

  Future<List<TodoModel>> getTodos();
}
