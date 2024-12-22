import 'package:class_flutter_1_todo/core/exceptions/failure.dart';
import 'package:class_flutter_1_todo/features/todo/domain/entities/todo.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TodoRepository {
  Future<Either<Failure, Todo>> addTodo({
    required String todo,
  });

  Future<Either<Failure, Todo>> updateTodo({
    required String id,
    String? todo,
    bool? isChecked,
  });

  Future<Either<Failure, void>> deleteTodo({
    required String id,
  });

  Future<Either<Failure, List<Todo>>> getTodos();
}
