import 'package:hive/hive.dart';
import 'package:vox/models/todo_model.dart';

class LocalTodoService {
  final Box<Todo> _todoBox;

  LocalTodoService(this._todoBox);

  Future<List<Todo>> getTodos({int offset = 0, int limit = 10}) async {
    final todos = _todoBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return todos.skip(offset).take(limit).toList();
  }

  Future<Todo> createTodo(Map<String, dynamic> data) async {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: data['title'],
      description: data['description'],
      category: data['category'],
      completed: data['completed'] ?? false,
      createdAt: DateTime.now(),
    );

    await _todoBox.put(todo.id, todo);
    return todo;
  }

  Future<void> clearAll() async {
    await _todoBox.clear();
  }
}
