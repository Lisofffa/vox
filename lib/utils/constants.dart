class AppConstants {
  static const String appTitle = 'ToDo Приложение';
  static const String addTodoTitle = 'Добавить задачу';
}

class ApiConstants {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String todosEndpoint = '/todos';
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration connectionTimeout = Duration(seconds: 15);
}

class CategoryConstants {
  static const List<String> categories = [
    'Все',
    'Работа',
    'Личное',
    'Покупки',
    'Другое'
  ];
}
