import 'package:class_flutter_1_todo/core/exceptions/server_exception.dart';
import 'package:class_flutter_1_todo/features/todo/data/models/todo_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'todo_remote_data_source.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final SupabaseClient _client;

  const TodoRemoteDataSourceImpl({
    required SupabaseClient client,
  }) : _client = client;

  Future<T> _run<T>(Future<T> Function() function) async {
    try {
      return await function();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> addTodo({required String todo}) {
    return _run(() async {
      final response = await _client
          .from('todos')
          .insert({
            'todo': todo,
            'checked': false,
          })
          .select()
          .single();

      return TodoModel.fromJson(response);
    });
  }

  @override
  Future<void> deleteTodo({required String id}) {
    return _run(() async {
      await _client.from('todos').delete().eq('id', id);
    });
  }

  @override
  Future<List<TodoModel>> getTodos() {
    return _run(() async {
      final response = await _client.from('todos').select().order(
            'created_at',
            ascending: false,
          );

      return TodoModel.fromJsonList(response);
    });
  }

  @override
  Future<TodoModel> updateTodo({
    required String id,
    String? todo,
    bool? isChecked,
  }) {
    return _run(() async {
      final data = <String, dynamic>{};

      if (todo != null) {
        data['todo'] = todo;
      }

      if (isChecked != null) {
        data['checked'] = isChecked;
      }

      final response = await _client
          .from('todos')
          .update(data)
          .eq('id', id)
          .select()
          .single();

      return TodoModel.fromJson(response);
    });
  }
}
