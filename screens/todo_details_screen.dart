import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import 'edit_todo_screen.dart';

class TodoDetailsScreen extends StatelessWidget {
  final Todo todo;
  const TodoDetailsScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, y hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo Details',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTodoScreen(todo: todo),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (todo.description != null && todo.description!.isNotEmpty)
              Text(
                todo.description!,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: todo.categoryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    todo.category,
                    style: GoogleFonts.poppins(
                      color: todo.categoryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    todo.isCompleted ? 'Completed' : 'Pending',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor:
                  todo.isCompleted ? Colors.green : Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                'Created at',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                dateFormat.format(todo.createdAt),
                style: GoogleFonts.poppins(),
              ),
            ),
            if (todo.dueDate != null) ...[
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(
                  Icons.timer,
                  color: todo.isOverdue ? Colors.red : null,
                ),
                title: Text(
                  'Due date',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                ),
                subtitle: Text(
                  dateFormat.format(todo.dueDate!),
                  style: GoogleFonts.poppins(
                    color: todo.isOverdue ? Colors.red : null,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}