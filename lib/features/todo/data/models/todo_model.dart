import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required super.id,
    required super.todo,
    required super.isChecked,
  });

  static TodoModel fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      isChecked: json['isChecked'] ?? false,
    );
  }

  static List<TodoModel> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => TodoModel.fromJson(json)).toList();
  }
}
