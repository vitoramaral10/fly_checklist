import '../../../domain/entities/entities.dart';

abstract class DashboardPresenter {
  bool get isLoading;
  String? get hasError;
  UserEntity? get user;
  int? get taskPriority;
  List<TaskEntity> get tasks;

  set taskPriority(int? value);

  Future<void> loadAllData();
  Future<void> loadUser();
  Future<void> getAllTasks();
  Future<void> createNewTask();
  void clearNewTaskFields();
  Future<void> toggleTaskCompletion(TaskEntity task);
  Future<void> onUpdateTask(TaskEntity task);
  Future<void> onDeleteTask(TaskEntity task);
}
