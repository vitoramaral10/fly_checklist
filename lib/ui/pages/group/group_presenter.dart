import '../../../domain/entities/entities.dart';

abstract class GroupPresenter {
  GroupEntity? get group;
  bool get isLoading;
  String? get hasError;
  List<TaskEntity> get tasks;
  UserEntity? get user;

  Future<void> loadUser();
  Future<void> getAllTasks();
}
