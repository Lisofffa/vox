import 'package:flutter/material.dart';
import 'package:vox/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(todo.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todo.description != null && todo.description!.isNotEmpty)
              Text(todo.description!),
            const SizedBox(height: 4),
            Chip(
              label: Text(todo.category),
              backgroundColor: _getCategoryColor(todo.category),
            ),
          ],
        ),
      ),
    );
  }

  Color? _getCategoryColor(String? category) {
    switch (category) {
      case 'Работа':
        return Colors.blue[100];
      case 'Личное':
        return Colors.green[100];
      case 'Покупки':
        return Colors.purple[100];
      case 'Другое':
        return Colors.orange[100];
      default:
        return Colors.grey[100];
    }
  }
}
