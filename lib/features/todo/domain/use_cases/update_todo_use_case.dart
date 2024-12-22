import 'package:class_flutter_1_todo/core/exceptions/failure.dart';
import 'package:class_flutter_1_todo/features/todo/domain/entities/todo.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository _repository;

  UpdateTodoUseCase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<Failure, Todo>> call({
    required String id,
    String? todo,
    bool? isChecked,
  }) async {
    return _repository.updateTodo(
      id: id,
      todo: todo,
      isChecked: isChecked,
    );
  }
}
