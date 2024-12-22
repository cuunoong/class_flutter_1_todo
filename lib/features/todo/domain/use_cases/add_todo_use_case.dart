import 'package:class_flutter_1_todo/core/exceptions/failure.dart';
import 'package:class_flutter_1_todo/features/todo/domain/entities/todo.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository _repository;

  AddTodoUseCase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<Failure, Todo>> call({
    required String todo,
  }) async {
    return _repository.addTodo(todo: todo);
  }
}
