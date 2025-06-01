import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final bool completed;

  @HiveField(5)
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.description,
    required this.category,
    this.completed = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'completed': completed,
        'createdAt': createdAt.toIso8601String(),
      };
}
