import '../../../domain/entities/entities.dart';
import '../group_form_presenter.dart';
import '../task_form_presenter.dart';

abstract class DashboardPresenter
    implements TaskFormPresenter, GroupFormPresenter {
  bool get isLoading;
  String? get hasError;
  UserEntity? get user;
  List<TaskEntity> get tasks;

  Future<void> loadAllData();
  Future<void> loadUser();

  Future<void> getAllTasks();

  Future<void> getAllGroups();
  Future<void> onCreateGroup();
}
