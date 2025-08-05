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
}
