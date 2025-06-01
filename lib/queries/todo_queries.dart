import 'dart:convert';
import 'api_client.dart';

class TodoQueries {
  final ApiClient apiClient;

  TodoQueries({
    required this.apiClient,
  });

  Future<List<Map<String, dynamic>>> fetchTodos(
      {int offset = 0, int limit = 10}) async {
    final response = await apiClient.getTodos(offset: offset, limit: limit);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Ошибка загрузки задач');
    }
  }

  Future<Map<String, dynamic>> createTodo(Map<String, dynamic> todoData) async {
    final response = await apiClient.addTodo(todoData);

    if (response.statusCode == 201) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Ошибка создания задачи');
    }
  }
}
