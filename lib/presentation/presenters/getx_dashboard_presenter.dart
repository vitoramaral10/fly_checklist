import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/helpers/helpers.dart';
import 'package:fly_checklist/ui/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxDashboardPresenter extends GetxController
    implements DashboardPresenter {
  final GetUser getUser;
  final LoadTasks loadTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  GetxDashboardPresenter({
    required this.getUser,
    required this.loadTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  });

  final formNewTaskKey = GlobalKey<FormState>();
  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskDueDateController = TextEditingController();

  final _isLoading = true.obs;
  final _hasError = Rxn<String>();
  final _user = Rxn<UserEntity>();
  final _taskPriority = Rxn<int>(2);
  final _tasks = <TaskEntity>[].obs;

  @override
  bool get isLoading => _isLoading.value;
  @override
  String? get hasError => _hasError.value;
  @override
  UserEntity? get user => _user.value;
  @override
  int? get taskPriority => _taskPriority.value;
  @override
  List<TaskEntity> get tasks => _tasks;

  @override
  set taskPriority(int? value) {
    if (value != null && value >= 1 && value <= 5) {
      _taskPriority.value = value;
    } else {
      _taskPriority.value = null;
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
      await getAllTasks();
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
  Future<void> getAllTasks() async {
    try {
      final tasks = await loadTasks.call(user!.uid);

      tasks.sort((a, b) {
        // Se ambos têm dueDate, ordena por dueDate (ascendente)
        if (a.dueDate != null && b.dueDate != null) {
          int cmp = a.dueDate!.compareTo(b.dueDate!);
          if (cmp != 0) return cmp;
          // Se dueDate igual, ordena por createdAt (ascendente)
          return a.createdAt.compareTo(b.createdAt);
        }
        // Se só a tem dueDate, a vem antes
        if (a.dueDate != null) return -1;
        // Se só b tem dueDate, b vem antes
        if (b.dueDate != null) return 1;
        // Se nenhum tem dueDate, ordena por createdAt (ascendente)
        return a.createdAt.compareTo(b.createdAt);
      });
      _tasks.value = tasks;
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
        task: TaskEntity(
          id: '',
          title: taskTitleController.text,
          description: taskDescriptionController.text,
          dueDate: taskDueDateController.text.isNotEmpty
              ? DateFormat.yMd().parse(taskDueDateController.text)
              : null,
          priority: taskPriority!,
          isDone: false,
          createdAt: DateTime.now(),
        ),
      );
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.createNewTask');
      throw UiError.unexpected;
    } finally {
      clearNewTaskFields();
      await getAllTasks();
    }
  }

  @override
  void clearNewTaskFields() {
    taskTitleController.clear();
    taskDescriptionController.clear();
    taskDueDateController.clear();
    taskPriority = 2;
    formNewTaskKey.currentState?.reset();
  }

  @override
  Future<void> toggleTaskCompletion(TaskEntity task) async {
    try {
      final updatedTask = task.copyWith(isDone: !task.isDone);

      _tasks[_tasks.indexOf(task)] = updatedTask;

      await updateTask.call(userId: user!.uid, task: updatedTask);
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.toggleTaskCompletion');

      _tasks[_tasks.indexOf(task)] = task;
      throw UiError.unexpected;
    }
  }

  @override
  Future<void> onUpdateTask(TaskEntity task) async {
    try {
      await updateTask.call(userId: user!.uid, task: task);
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.onUpdateTask');

      throw UiError.unexpected;
    } finally {
      clearNewTaskFields();
      await getAllTasks();
    }
  }

  @override
  Future<void> onDeleteTask(TaskEntity task) async {
    try {
      await deleteTask.call(userId: user!.uid, task: task);
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.onDeleteTask');

      throw UiError.unexpected;
    } finally {
      await getAllTasks();
    }
  }
}
