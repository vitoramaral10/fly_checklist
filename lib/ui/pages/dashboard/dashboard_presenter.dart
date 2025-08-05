import '../../../domain/entities/entities.dart';

abstract class DashboardPresenter {
  bool get isLoading;
  String? get hasError;
  UserEntity? get user;
  int? get newTaskPriority;
  List<TaskEntity> get tasks;

  set newTaskPriority(int? value);

  Future<void> loadAllData();
  Future<void> loadUser();
  Future<void> getAllTasks();
  Future<void> createNewTask();
  void clearNewTaskFields();
}
