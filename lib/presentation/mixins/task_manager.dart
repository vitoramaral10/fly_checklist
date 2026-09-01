import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import 'user_manager.dart';

mixin TaskManager on GetxController, UserManager {
  CreateTask get createTask;
  UpdateTask get updateTask;
  DeleteTask get deleteTask;

  List<TaskEntity> get tasks;

  Future<void> refreshTasks();

  final formNewTaskKey = GlobalKey<FormState>();
  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskDueDateController = TextEditingController();

  final _taskPriority = Rxn<int>(2);
  final _taskGroupId = Rxn<String>();

  int? get taskPriority => _taskPriority.value;

  String? get taskGroupId => _taskGroupId.value;

  set taskPriority(int? value) {
    if (value != null &&
        value >= TaskEntity.minPriority &&
        value <= TaskEntity.maxPriority) {
      _taskPriority.value = value;
    } else {
      _taskPriority.value = null;
    }
  }

  set taskGroupId(String? value) {
    _taskGroupId.value = value;
  }

  Future<void> onCreateTask() async {
    final dueDate = _parseDueDate(taskDueDateController.text);

    if (dueDate != null && isDateInPast(dueDate)) {
      throw UiError.invalidDueDate;
    }

    try {
      await createTask.call(
        userId: currentUserId,
        task: TaskEntity(
          id: '',
          groupId: taskGroupId,
          title: taskTitleController.text,
          description: taskDescriptionController.text,
          dueDate: dueDate,
          priority: taskPriority!,
          isDone: false,
          createdAt: DateTime.now(),
        ),
      );
    } on DomainError catch (e) {
      log(e.toString(), name: '$runtimeType.onCreateTask');
      throw UiError.unexpected;
    } finally {
      clearTaskFields();
      await refreshTasks();
    }
  }

  Future<void> onUpdateTask(TaskEntity task) async {
    if (task.dueDate != null && isDateInPast(task.dueDate!)) {
      throw UiError.invalidDueDate;
    }

    try {
      await updateTask.call(userId: currentUserId, task: task);
    } on DomainError catch (e) {
      log(e.toString(), name: '$runtimeType.onUpdateTask');
      throw UiError.unexpected;
    } finally {
      clearTaskFields();
      await refreshTasks();
    }
  }

  Future<void> onDeleteTask(TaskEntity task) async {
    try {
      await deleteTask.call(userId: currentUserId, task: task);
    } on DomainError catch (e) {
      log(e.toString(), name: '$runtimeType.onDeleteTask');
      throw UiError.unexpected;
    } finally {
      await refreshTasks();
    }
  }

  Future<void> toggleTaskCompletion(TaskEntity task) async {
    final index = tasks.indexOf(task);

    try {
      final updatedTask = task.copyWith(isDone: !task.isDone);

      if (index != -1) {
        tasks[index] = updatedTask;
      }

      await updateTask.call(userId: currentUserId, task: updatedTask);
    } on DomainError catch (e) {
      log(e.toString(), name: '$runtimeType.toggleTaskCompletion');

      if (index != -1) {
        tasks[index] = task;
      }
      throw UiError.unexpected;
    } finally {
      await refreshTasks();
    }
  }

  /// Concluídas por último, depois por data de vencimento e por criação.
  void sortTasks(List<TaskEntity> list) {
    list.sort((a, b) {
      if (a.isDone && !b.isDone) return 1;
      if (!a.isDone && b.isDone) return -1;

      if (a.dueDate != null && b.dueDate != null) {
        final cmp = a.dueDate!.compareTo(b.dueDate!);
        if (cmp != 0) return cmp;
        return a.createdAt.compareTo(b.createdAt);
      }
      if (a.dueDate != null) return -1;
      if (b.dueDate != null) return 1;
      return a.createdAt.compareTo(b.createdAt);
    });
  }

  void clearTaskFields() {
    taskTitleController.clear();
    taskDescriptionController.clear();
    taskDueDateController.clear();
    taskPriority = 2;
    taskGroupId = null;
    formNewTaskKey.currentState?.reset();
  }

  void disposeTaskFields() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    taskDueDateController.dispose();
  }

  DateTime? _parseDueDate(String value) {
    if (value.trim().isEmpty) return null;
    try {
      return appDateFormat.parseStrict(value.trim());
    } on FormatException catch (e) {
      log(e.toString(), name: '$runtimeType._parseDueDate');
      throw UiError.invalidDueDate;
    }
  }
}
