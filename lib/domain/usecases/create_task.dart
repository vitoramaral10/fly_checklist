import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CreateTask {
  Future<void> call({required String userId, required CreateTaskParams params});
}

class CreateTaskParams {
  final String title;
  final String? description;
  final DateTime? dueDate;
  final int priority;

  CreateTaskParams({
    required this.title,
    this.description,
    this.dueDate,
    required this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'priority': priority,
    };
  }
}
