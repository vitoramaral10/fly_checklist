import '../../../domain/entities/entities.dart';
import '../../helpers/ui_error.dart';
import '../group_form_presenter.dart';
import '../task_form_presenter.dart';

abstract class GroupPresenter implements TaskFormPresenter, GroupFormPresenter {
  GroupEntity? get group;
  bool get isLoading;
  UiError? get hasError;
  List<TaskEntity> get tasks;
  UserEntity? get user;

  Future<void> loadAllData();
  Future<void> loadUser();
  Future<void> loadGroup();
  Future<void> getAllTasks();

  /// Desmarca todas as tarefas do grupo aberto, a pedido do usuário.
  Future<void> onResetGroupTasks();
}
