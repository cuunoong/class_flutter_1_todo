part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class InitialState extends TodoState {}

final class LoadingState extends TodoState {}

final class SuccessState<T> extends TodoState {
  final T data;
  final Type type;

  SuccessState(this.data, this.type);
}

final class FailureState extends TodoState {
  final String message;

  FailureState(this.message);
}
