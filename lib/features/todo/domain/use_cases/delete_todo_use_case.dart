import 'package:class_flutter_1_todo/core/exceptions/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository _repository;

  DeleteTodoUseCase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<Failure, void>> call({
    required String id,
  }) async {
    return _repository.deleteTodo(id: id);
  }
}
