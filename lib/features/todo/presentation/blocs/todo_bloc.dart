import 'package:class_flutter_1_todo/features/todo/domain/use_cases/add_todo_use_case.dart';
import 'package:class_flutter_1_todo/features/todo/domain/use_cases/delete_todo_use_case.dart';
import 'package:class_flutter_1_todo/features/todo/domain/use_cases/get_todos_use_case.dart';
import 'package:class_flutter_1_todo/features/todo/domain/use_cases/update_todo_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_state.dart';
part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase _getTodosUseCase;
  final AddTodoUseCase _addTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;

  TodoBloc({
    required GetTodosUseCase getTodosUseCase,
    required AddTodoUseCase addTodoUseCase,
    required UpdateTodoUseCase updateTodoUseCase,
    required DeleteTodoUseCase deleteTodoUseCase,
  })  : _getTodosUseCase = getTodosUseCase,
        _addTodoUseCase = addTodoUseCase,
        _updateTodoUseCase = updateTodoUseCase,
        _deleteTodoUseCase = deleteTodoUseCase,
        super(InitialState()) {
    on<GetTodosEvent>(_getTodos);
    on<AddTodoEvent>(_addTodo);
    on<UpdateTodoEvent>(_updateTodo);
    on<DeleteTodoEvent>(_deleteTodo);
  }

  void _getTodos(GetTodosEvent event, Emitter<TodoState> emit) async {
    emit(LoadingState());
    final result = await _getTodosUseCase();
    result.fold(
      (failure) => emit(FailureState(failure.message)),
      (todos) => emit(SuccessState(todos, Type.get)),
    );
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(LoadingState());
    final result = await _addTodoUseCase(todo: event.todo);
    result.fold(
      (failure) => emit(FailureState(failure.message)),
      (todo) => emit(SuccessState(todo, Type.add)),
    );
  }

  void _updateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    emit(LoadingState());
    final result = await _updateTodoUseCase(
      id: event.id,
      todo: event.todo,
      isChecked: event.isChecked,
    );
    result.fold(
      (failure) => emit(FailureState(failure.message)),
      (todo) => emit(SuccessState(todo, Type.update)),
    );
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    emit(LoadingState());
    final result = await _deleteTodoUseCase(id: event.id);
    result.fold(
      (failure) => emit(FailureState(failure.message)),
      (_) => emit(SuccessState(null, Type.delete)),
    );
  }
}

enum Type {
  add,
  update,
  delete,
  get,
}
