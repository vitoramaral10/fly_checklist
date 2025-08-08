class TaskEntity {
  final String id;
  final String? groupId;
  final String title;
  final String description;
  final DateTime? dueDate;
  final int priority;
  final bool isDone;
  final DateTime createdAt;

  TaskEntity({
    required this.id,
    this.groupId,
    required this.title,
    required this.description,
    this.dueDate,
    required this.priority,
    required this.isDone,
    required this.createdAt,
  }) : assert(title.trim().isNotEmpty, 'TaskEntity.title must not be empty'),
       assert(
         priority >= 0 && priority <= 4,
         'TaskEntity.priority must be between 0 and 4',
       ),
       assert(
         dueDate == null || dueDate.isAfter(DateTime.now()),
         'TaskEntity.dueDate must be in the future when provided',
       );

  TaskEntity copyWith({
    String? title,
    String? groupId,
    String? description,
    DateTime? dueDate,
    int? priority,
    bool? isDone,
  }) {
    return TaskEntity(
      id: id,
      groupId: groupId ?? this.groupId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt,
    );
  }
}
