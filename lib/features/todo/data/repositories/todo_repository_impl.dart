import 'package:class_flutter_1_todo/core/exceptions/failure.dart';
import 'package:class_flutter_1_todo/core/exceptions/server_exception.dart';
import 'package:class_flutter_1_todo/features/todo/data/data_sources/todo_remote_data_source.dart';

import 'package:class_flutter_1_todo/features/todo/domain/entities/todo.dart';

import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _remoteDataSource;

  const TodoRepositoryImpl({
    required TodoRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  Future<Either<Failure, T>> _run<T>(Future<T> Function() function) async {
    try {
      final data = await function();
      return right(data);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Todo>> addTodo({required String todo}) {
    return _run(() => _remoteDataSource.addTodo(todo: todo));
  }

  @override
  Future<Either<Failure, void>> deleteTodo({required String id}) {
    return _run(() => _remoteDataSource.deleteTodo(id: id));
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() {
    return _run(() => _remoteDataSource.getTodos());
  }

  @override
  Future<Either<Failure, Todo>> updateTodo({
    required String id,
    String? todo,
    bool? isChecked,
  }) {
    return _run(
      () => _remoteDataSource.updateTodo(
        id: id,
        todo: todo,
        isChecked: isChecked,
      ),
    );
  }
}
