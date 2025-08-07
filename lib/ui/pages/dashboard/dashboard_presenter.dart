import 'package:flutter/material.dart';

import '../../../domain/entities/entities.dart';

abstract class DashboardPresenter {
  bool get isLoading;
  String? get hasError;
  UserEntity? get user;
  int? get taskPriority;
  List<TaskEntity> get tasks;
  List<GroupEntity> get groups;
  IconData get groupIcon;
  Color get groupColor;
  bool get saveCheckState;

  set taskPriority(int? value);
  set groupIcon(IconData value);
  set groupColor(Color value);
  set saveCheckState(bool value);

  Future<void> loadAllData();
  Future<void> loadUser();
  void clearFields();
  Future<void> toggleTaskCompletion(TaskEntity task);

  Future<void> getAllTasks();
  Future<void> onCreateTask();
  Future<void> onUpdateTask(TaskEntity task);
  Future<void> onDeleteTask(TaskEntity task);

  Future<void> getAllGroups();
  Future<void> onCreateGroup();
  Future<void> onUpdateGroup(GroupEntity group);
  Future<void> onDeleteGroup(GroupEntity group);
}
