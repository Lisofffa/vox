import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vox/providers/todo_provider.dart';
import 'package:vox/utils/constants.dart';

class CategoryFilter extends ConsumerWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryFilterProvider);

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: CategoryConstants.categories.length,
        itemBuilder: (context, index) {
          final category = CategoryConstants.categories[index];
          final isSelected = selectedCategory == category ||
              (selectedCategory == null && category == 'Все');

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) => _handleCategorySelection(ref, category),
            ),
          );
        },
      ),
    );
  }

  void _handleCategorySelection(WidgetRef ref, String category) {
    ref.read(categoryFilterProvider.notifier).state =
        category == 'Все' ? null : category;
  }
}
