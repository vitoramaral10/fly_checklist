import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import 'task_manager.dart';
import 'user_manager.dart';

mixin GroupManager on GetxController, UserManager, TaskManager {
  UpdateGroup get updateGroup;
  DeleteGroup get deleteGroup;

  Future<void> refreshGroups();

  final formNewGroupKey = GlobalKey<FormState>();
  final groupNameController = TextEditingController();
  final groupDescriptionController = TextEditingController();

  final _groupIcon = defaultGroupIcon.obs;
  final Rx<Color> _groupColor = Colors.blue.obs;
  final _saveCheckState = true.obs;

  IconData get groupIcon => _groupIcon.value;

  Color get groupColor => _groupColor.value;

  bool get saveCheckState => _saveCheckState.value;

  set groupIcon(IconData value) {
    _groupIcon.value = value;
  }

  set groupColor(Color value) {
    _groupColor.value = value;
  }

  set saveCheckState(bool value) {
    _saveCheckState.value = value;
  }

  Future<void> onUpdateGroup(GroupEntity group) async {
    try {
      await updateGroup.call(userId: currentUserId, group: group);
    } on DomainError catch (e) {
      log(e.toString(), name: '$runtimeType.onUpdateGroup');
      throw UiError.unexpected;
    } finally {
      clearGroupFields();
      await refreshGroups();
    }
  }

  Future<void> onDeleteGroup(GroupEntity group) async {
    // As tarefas do grupo somem junto com ele, então os lembretes delas
    // precisam ser recolhidos antes de perdermos a lista.
    final taskIds = allKnownTasks
        .where((task) => task.groupId == group.id)
        .map((task) => task.id)
        .toList();

    try {
      await deleteGroup.call(userId: currentUserId, group: group);

      await cancelTaskRemindersFor(taskIds);
    } on DomainError catch (e) {
      log(e.toString(), name: '$runtimeType.onDeleteGroup');
      throw UiError.unexpected;
    } finally {
      await refreshGroups();
      await refreshTasks();
    }
  }

  void clearGroupFields() {
    groupNameController.clear();
    groupDescriptionController.clear();
    groupIcon = defaultGroupIcon;
    groupColor = Colors.blue;
    saveCheckState = true;
    formNewGroupKey.currentState?.reset();
  }

  void disposeGroupFields() {
    groupNameController.dispose();
    groupDescriptionController.dispose();
  }
}
