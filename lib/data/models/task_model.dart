import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/entities.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  final int priority;
  final bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.dueDate,
    required this.priority,
    required this.isDone,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: json['dueDate'] != null
          ? (json['dueDate'] as Timestamp).toDate()
          : null,
      priority: json['priority'] as int,
      isDone: json['isDone'] as bool? ?? false,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
      isDone: isDone, // Default value, can be changed later
    );
  }
}
