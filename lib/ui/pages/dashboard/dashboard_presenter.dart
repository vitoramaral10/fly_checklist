import '../../../domain/entities/entities.dart';
import '../../helpers/ui_error.dart';
import '../group_form_presenter.dart';
import '../task_form_presenter.dart';

abstract class DashboardPresenter
    implements TaskFormPresenter, GroupFormPresenter {
  bool get isLoading;
  UiError? get hasError;
  UserEntity? get user;
  List<TaskEntity> get tasks;

  Future<void> loadAllData();
  Future<void> loadUser();

  Future<void> getAllTasks();

  Future<void> getAllGroups();
  Future<void> onCreateGroup();
}
