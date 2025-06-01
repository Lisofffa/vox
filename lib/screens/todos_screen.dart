import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vox/models/todo_model.dart';
import 'package:vox/providers/todo_provider.dart';
import 'package:vox/screens/add_todo_screen.dart';
import 'package:vox/utils/constants.dart';
import 'package:vox/widgets/category_filter.dart';
import 'package:vox/widgets/todo_item.dart';

class TodosScreen extends ConsumerWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosState = ref.watch(todosPaginationProvider);
    final filteredTodos = ref.watch(filteredTodosProvider);
    final paginationNotifier = ref.read(todosPaginationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => paginationNotifier.refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          const CategoryFilter(),
          Expanded(
            child: todosState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (_) => _buildTodoList(filteredTodos, paginationNotifier),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddScreen(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoList(
    List<Todo> todos,
    TodosPaginationNotifier notifier,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
          notifier.loadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () => notifier.refresh(),
        child: ListView.builder(
          itemCount: todos.length + (notifier.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= todos.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return TodoItem(todo: todos[index]);
          },
        ),
      ),
    );
  }

  Future<void> _navigateToAddScreen(BuildContext context, WidgetRef ref) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoScreen()),
    );
    ref.read(todosPaginationProvider.notifier).refresh();
  }
}
