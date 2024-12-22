part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class GetTodosEvent extends TodoEvent {}

final class AddTodoEvent extends TodoEvent {
  final String todo;

  AddTodoEvent(this.todo);
}

final class UpdateTodoEvent extends TodoEvent {
  final String id;
  final String? todo;
  final bool? isChecked;

  UpdateTodoEvent(
    this.id, {
    this.todo,
    this.isChecked,
  });
}

final class DeleteTodoEvent extends TodoEvent {
  final String id;

  DeleteTodoEvent(this.id);
}
