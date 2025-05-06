import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../theme/app_theme.dart';
import 'todo_details_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _dateFormat = DateFormat('MMM d, y');
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final _categories = ['All', 'Personal', 'Work', 'School', 'Urgent'];

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);
    final username = ModalRoute.of(context)?.settings.arguments as String? ?? 'User';
    final theme = ref.watch(appThemeProvider);

    final filteredTodos = todos.where((todo) {
      final matchesSearch = todo.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (todo.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      final matchesCategory = _selectedCategory == 'All' || todo.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username'),
        actions: [
          IconButton(
            icon: Icon(theme.themeMode == AppThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => ref.read(appThemeProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search todos',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).cardTheme.color,
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FilterChip(
                    label: Text(_categories[index]),
                    selected: _selectedCategory == _categories[index],
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = _categories[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredTodos.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No todos found',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                final todo = filteredTodos[index];
                return Dismissible(
                  key: Key(todo.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    ref.read(todoListProvider.notifier).removeTodo(todo.id);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (value) {
                          ref.read(todoListProvider.notifier).toggleTodo(todo.id);
                        },
                      ),
                      title: Text(
                        todo.title,
                        style: GoogleFonts.poppins(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: todo.isCompleted
                              ? Colors.grey
                              : null,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (todo.description != null && todo.description!.isNotEmpty)
                            Text(
                              todo.description!,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                              ),
                            ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: todo.categoryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  todo.category,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: todo.categoryColor,
                                  ),
                                ),
                              ),
                              if (todo.dueDate != null) ...[
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: todo.isOverdue
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _dateFormat.format(todo.dueDate!),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: todo.isOverdue
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoDetailsScreen(todo: todo),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime? selectedDate;
    String selectedCategory = 'Personal';
    Color selectedColor = Colors.blue;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Add New Todo',
                style: GoogleFonts.poppins(),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description (optional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      items: _categories
                          .where((cat) => cat != 'All')
                          .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                          selectedColor = _getCategoryColor(value!);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedDate == null
                                ? 'No due date'
                                : 'Due: ${_dateFormat.format(selectedDate!)}',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() => selectedDate = date);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty) {
                      ref.read(todoListProvider.notifier).addTodo(
                        Todo(
                          title: titleController.text,
                          description: descriptionController.text.isEmpty
                              ? null
                              : descriptionController.text,
                          dueDate: selectedDate,
                          category: selectedCategory,
                          categoryColor: selectedColor,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    return switch (category) {
      'Personal' => Colors.blue,
      'Work' => Colors.green,
      'School' => Colors.orange,
      'Urgent' => Colors.red,
      _ => Colors.blue,
    };
  }
}
