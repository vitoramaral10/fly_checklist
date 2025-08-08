import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/entities.dart';

class TaskModel {
  final String id;
  final String? groupId;
  final String title;
  final String description;
  final DateTime? dueDate;
  final int priority;
  final bool isDone;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    this.groupId,
    required this.title,
    required this.description,
    this.dueDate,
    required this.priority,
    required this.isDone,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      groupId: json['groupId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: json['dueDate'] != null
          ? (json['dueDate'] as Timestamp).toDate()
          : null,
      priority: json['priority'] as int,
      isDone: json['isDone'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      groupId: groupId,
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
      isDone: isDone, // Default value, can be changed later
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'priority': priority,
      'isDone': isDone,
      'createdAt': Timestamp.fromDate(createdAt),
      'groupId': groupId,
    };
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      dueDate: entity.dueDate,
      priority: entity.priority,
      isDone: entity.isDone,
      groupId: entity.groupId,
      createdAt: entity.createdAt,
    );
  }
}
