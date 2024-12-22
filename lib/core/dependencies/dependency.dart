import 'package:class_flutter_1_todo/features/todo/data/data_sources/todo_remote_data_source.dart';
import 'package:class_flutter_1_todo/features/todo/data/data_sources/todo_remote_data_source_impl.dart';
import 'package:class_flutter_1_todo/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:class_flutter_1_todo/features/todo/domain/repositories/todo_repository.dart';
import 'package:class_flutter_1_todo/features/todo/domain/use_cases/add_todo_use_case.dart';
import 'package:class_flutter_1_todo/features/todo/domain/use_cases/delete_todo_use_case.dart';
import 'package:class_flutter_1_todo/features/todo/domain/use_cases/get_todos_use_case.dart';
import 'package:class_flutter_1_todo/features/todo/domain/use_cases/update_todo_use_case.dart';
import 'package:class_flutter_1_todo/features/todo/presentation/blocs/todo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final di = GetIt.instance;

initDependency() async {
  await Supabase.initialize(
    url: "https://bysvywircyxywtunqhss.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ5c3Z5d2lyY3l4eXd0dW5xaHNzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ4MzgwMDAsImV4cCI6MjA1MDQxNDAwMH0.nflC1GRCBvN-qPxnrlh1Ii4c5Xg47aMWB5LAmQauVCI",
  );
  final session = Supabase.instance.client.auth.currentSession;

  if (session == null) {
    await Supabase.instance.client.auth.signInAnonymously();
  }

  di.registerLazySingleton(() => Supabase.instance.client);

  // Datasources
  di.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(client: di()),
  );

  // Repositories
  di.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(remoteDataSource: di()),
  );

  // Use cases
  di.registerLazySingleton(() => GetTodosUseCase(repository: di()));
  di.registerLazySingleton(() => AddTodoUseCase(repository: di()));
  di.registerLazySingleton(() => UpdateTodoUseCase(repository: di()));
  di.registerLazySingleton(() => DeleteTodoUseCase(repository: di()));

  // Blocs
  di.registerFactory(
    () => TodoBloc(
      getTodosUseCase: di(),
      addTodoUseCase: di(),
      updateTodoUseCase: di(),
      deleteTodoUseCase: di(),
    ),
  );
}
