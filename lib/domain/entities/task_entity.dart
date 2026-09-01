import '../helpers/helpers.dart';

class TaskEntity {
  static const Object _unset = Object();

  static const int minPriority = 0;
  static const int maxPriority = 4;

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
  }) {
    if (title.trim().isEmpty) {
      throw DomainError.invalidTitle;
    }
    if (priority < minPriority || priority > maxPriority) {
      throw DomainError.invalidPriority;
    }
  }

  TaskEntity copyWith({
    String? title,
    Object? groupId = _unset,
    String? description,
    Object? dueDate = _unset,
    int? priority,
    bool? isDone,
  }) {
    return TaskEntity(
      id: id,
      groupId: identical(groupId, _unset) ? this.groupId : groupId as String?,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: identical(dueDate, _unset)
          ? this.dueDate
          : dueDate as DateTime?,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt,
    );
  }
}
