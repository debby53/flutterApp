import 'package:flutter/material.dart';

class Todo {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;
  final String category;
  final Color categoryColor;

  Todo({
    String? id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
    this.dueDate,
    this.category = 'Personal',
    this.categoryColor = Colors.blue,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt = createdAt ?? DateTime.now();

  Todo copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    String? category,
    Color? categoryColor,
  }) {
    return Todo(
      id: this.id, // Pass the existing ID
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: this.createdAt, // Pass the existing createdAt
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      categoryColor: categoryColor ?? this.categoryColor,
    );
  }

  bool get isOverdue => dueDate != null && dueDate!.isBefore(DateTime.now());
}