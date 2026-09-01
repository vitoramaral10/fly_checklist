import '../../../domain/entities/entities.dart';
import '../group_form_presenter.dart';
import '../task_form_presenter.dart';

abstract class GroupPresenter
    implements TaskFormPresenter, GroupFormPresenter {
  GroupEntity? get group;
  bool get isLoading;
  String? get hasError;
  List<TaskEntity> get tasks;
  UserEntity? get user;

  Future<void> loadAllData();
  Future<void> loadUser();
  Future<void> loadGroup();
  Future<void> getAllTasks();
}
