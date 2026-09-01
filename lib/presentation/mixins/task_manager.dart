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
  ScheduleTaskReminder get scheduleTaskReminder;
  CancelTaskReminder get cancelTaskReminder;

  List<TaskEntity> get tasks;

  /// Grupos visíveis para o presenter, usados para nomear o grupo no lembrete.
  List<GroupEntity> get groups;

  /// Todas as tarefas que o presenter conhece, não só as que ele exibe.
  ///
  /// A dashboard mostra apenas as tarefas sem grupo, mas carrega todas; quem
  /// precisa varrer as tarefas de um grupo (para cancelar lembretes, por
  /// exemplo) usa esta lista.
  Iterable<TaskEntity> get allKnownTasks => tasks;

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
      final task = TaskEntity(
        id: '',
        groupId: taskGroupId,
        title: taskTitleController.text,
        description: taskDescriptionController.text,
        dueDate: dueDate,
        priority: taskPriority!,
        isDone: false,
        createdAt: DateTime.now(),
      );

      final createdId = await createTask.call(
        userId: currentUserId,
        task: task,
      );

      // O lembrete é chaveado pelo id, que só existe depois de gravar.
      await syncTaskReminder(_withId(task, createdId));
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

      // Cobre os três casos de uma edição: data nova agenda, data removida
      // cancela, data mantida reagenda por cima do lembrete anterior.
      await syncTaskReminder(task);
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

      await cancelTaskReminderFor(task.id);
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

      // Concluir cancela o lembrete; reabrir reagenda, desde que a data ainda
      // esteja no futuro.
      await syncTaskReminder(updatedTask);
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

  /// Põe o lembrete da tarefa em dia com o estado dela.
  ///
  /// Nunca propaga erro: lembrete é acessório, e falhar em agendar não pode
  /// derrubar o salvamento que já aconteceu no repositório.
  Future<void> syncTaskReminder(TaskEntity task) async {
    try {
      await scheduleTaskReminder.call(
        task: task,
        groupName: _groupNameOf(task.groupId),
      );
    } catch (e) {
      log(e.toString(), name: '$runtimeType.syncTaskReminder');
    }
  }

  Future<void> syncTaskReminders(Iterable<TaskEntity> tasks) async {
    for (final task in tasks) {
      await syncTaskReminder(task);
    }
  }

  /// Cancela o lembrete de uma tarefa que deixou de existir, em silêncio.
  Future<void> cancelTaskReminderFor(String taskId) async {
    try {
      await cancelTaskReminder.call(taskId: taskId);
    } catch (e) {
      log(e.toString(), name: '$runtimeType.cancelTaskReminderFor');
    }
  }

  Future<void> cancelTaskRemindersFor(Iterable<String> taskIds) async {
    for (final taskId in taskIds) {
      await cancelTaskReminderFor(taskId);
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

  String? _groupNameOf(String? groupId) {
    if (groupId == null) return null;

    for (final group in groups) {
      if (group.id == groupId) return group.name;
    }
    return null;
  }

  /// Recria a tarefa com o id devolvido pela gravação.
  ///
  /// `copyWith` preserva o id de propósito, então a cópia é explícita.
  TaskEntity _withId(TaskEntity task, String id) => TaskEntity(
    id: id,
    groupId: task.groupId,
    title: task.title,
    description: task.description,
    dueDate: task.dueDate,
    priority: task.priority,
    isDone: task.isDone,
    createdAt: task.createdAt,
  );

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
