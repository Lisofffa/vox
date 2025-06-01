import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vox/utils/constants.dart';

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<http.Response> getTodos({int offset = 0, int limit = 10}) async {
    return await client.get(
      Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.todosEndpoint}?offset=$offset&limit=$limit'),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<http.Response> addTodo(Map<String, dynamic> todoData) async {
    return await client.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.todosEndpoint}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todoData),
    );
  }
}
