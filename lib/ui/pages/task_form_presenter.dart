import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

/// Contrato do formulário de tarefas, compartilhado por todas as páginas que
/// abrem o `TaskBottomSheet`.
abstract class TaskFormPresenter {
  GlobalKey<FormState> get formNewTaskKey;
  TextEditingController get taskTitleController;
  TextEditingController get taskDescriptionController;
  TextEditingController get taskDueDateController;
  int? get taskPriority;
  String? get taskGroupId;
  List<GroupEntity> get groups;

  set taskPriority(int? value);
  set taskGroupId(String? value);

  void clearFields();

  Future<void> onCreateTask();
  Future<void> onUpdateTask(TaskEntity task);
  Future<void> onDeleteTask(TaskEntity task);
  Future<void> toggleTaskCompletion(TaskEntity task);
}
