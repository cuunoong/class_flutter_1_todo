import 'package:class_flutter_1_todo/core/exceptions/failure.dart';
import 'package:class_flutter_1_todo/features/todo/domain/entities/todo.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository _repository;

  GetTodosUseCase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<Failure, List<Todo>>> call() async {
    return _repository.getTodos();
  }
}
