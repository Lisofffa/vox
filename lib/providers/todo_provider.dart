import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:vox/models/todo_model.dart';
import 'package:vox/services/local_todo_service.dart';

final localTodoServiceProvider = Provider<LocalTodoService>((ref) {
  final box = Hive.box<Todo>('todos');
  return LocalTodoService(box);
});

final todosPaginationProvider =
    StateNotifierProvider<TodosPaginationNotifier, AsyncValue<List<Todo>>>(
        (ref) {
  return TodosPaginationNotifier(ref);
});

class TodosPaginationNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  final Ref ref;
  int offset = 0;
  final int limit = 10;
  bool hasMore = true;

  TodosPaginationNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (!hasMore) return;

    try {
      final newTodos = await ref
          .read(localTodoServiceProvider)
          .getTodos(offset: offset, limit: limit);

      hasMore = newTodos.length == limit;
      offset += newTodos.length;

      state = AsyncValue.data([
        ...state.value ?? [],
        ...newTodos,
      ]);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    offset = 0;
    hasMore = true;
    state = const AsyncValue.loading();
    await loadMore();
  }
}

final categoryFilterProvider = StateProvider<String?>((ref) => null);

final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todosPaginationProvider).value ?? [];
  final category = ref.watch(categoryFilterProvider);

  if (category == null || category == 'Все') {
    return todos;
  }
  return todos.where((todo) => todo.category == category).toList();
});
