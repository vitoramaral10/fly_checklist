class TaskEntity {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  final int priority;
  final bool isDone;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    this.dueDate,
    required this.priority,
    required this.isDone,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? priority,
    bool? isDone,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
    );
  }
}
