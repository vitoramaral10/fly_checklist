import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/helpers/helpers.dart';
import 'package:fly_checklist/ui/helpers/helpers.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxDashboardPresenter extends GetxController
    implements DashboardPresenter {
  final GetUser getUser;
  final CreateTask createTask;

  GetxDashboardPresenter({required this.getUser, required this.createTask});

  final formNewTaskKey = GlobalKey<FormState>();
  final newTaskTitleController = TextEditingController();
  final newTaskDescriptionController = TextEditingController();
  final newTaskDueDateController = TextEditingController();

  final _isLoading = true.obs;
  final _hasError = Rxn<String>();
  final _user = Rxn<UserEntity>();
  final _newTaskPriority = Rxn<int>(2);

  @override
  bool get isLoading => _isLoading.value;
  @override
  String? get hasError => _hasError.value;
  @override
  UserEntity? get user => _user.value;
  @override
  int? get newTaskPriority => _newTaskPriority.value;

  @override
  set newTaskPriority(int? value) {
    if (value != null && value >= 1 && value <= 5) {
      _newTaskPriority.value = value;
    } else {
      _newTaskPriority.value = null;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    await loadAllData();
    _isLoading.value = false;
  }

  @override
  Future<void> loadAllData() async {
    try {
      await loadUser();
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.loadAllData');
      _hasError.value = UiError.unexpected.message;
      _user.value = null;
    }
  }

  @override
  Future<void> loadUser() async {
    try {
      final user = await getUser.call();
      _user.value = user;
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.loadUser');
      throw DomainError.unexpected;
    }
  }

  @override
  Future<void> createNewTask() async {
    try {
      await createTask.call(
        userId: user!.uid,
        params: CreateTaskParams(
          title: newTaskTitleController.text,
          description: newTaskDescriptionController.text,
          dueDate: DateTime.tryParse(newTaskDueDateController.text),
          priority: newTaskPriority ?? 2,
        ),
      );
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.createNewTask');
      throw UiError.unexpected;
    }
  }

  @override
  void clearNewTaskFields() {
    newTaskTitleController.clear();
    newTaskDescriptionController.clear();
    newTaskDueDateController.clear();
    newTaskPriority = 2;
    formNewTaskKey.currentState?.reset();
  }
}
