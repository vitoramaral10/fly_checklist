import 'dart:developer';

import 'package:fly_checklist/domain/helpers/helpers.dart';
import 'package:fly_checklist/ui/helpers/helpers.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxDashboardPresenter extends GetxController
    with UserManager, TaskManager, GroupManager
    implements DashboardPresenter {
  @override
  final GetUser getUser;
  final LoadTasks loadTasks;
  @override
  final CreateTask createTask;
  @override
  final UpdateTask updateTask;
  @override
  final DeleteTask deleteTask;
  @override
  final ScheduleTaskReminder scheduleTaskReminder;
  @override
  final CancelTaskReminder cancelTaskReminder;
  final LoadGroups loadGroups;
  final CreateGroup createGroup;
  @override
  final UpdateGroup updateGroup;
  @override
  final DeleteGroup deleteGroup;

  GetxDashboardPresenter({
    required this.getUser,
    required this.loadTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
    required this.scheduleTaskReminder,
    required this.cancelTaskReminder,
    required this.loadGroups,
    required this.createGroup,
    required this.updateGroup,
    required this.deleteGroup,
  });

  final _isLoading = true.obs;
  final _hasError = Rxn<UiError>();
  final _tasks = <TaskEntity>[].obs;
  final _groups = <GroupEntity>[].obs;
  final _allTasks = <TaskEntity>[];

  @override
  bool get isLoading => _isLoading.value;
  @override
  UiError? get hasError => _hasError.value;
  @override
  List<TaskEntity> get tasks => _tasks;
  @override
  List<GroupEntity> get groups => _groups;

  /// A dashboard exibe só as tarefas sem grupo, mas carrega todas — e são
  /// todas que importam para manter os lembretes em dia.
  @override
  Iterable<TaskEntity> get allKnownTasks => _allTasks;

  @override
  Future<void> onInit() async {
    super.onInit();

    await loadAllData();
  }

  @override
  Future<void> loadAllData() async {
    _hasError.value = null;
    try {
      await loadUser();
      await getAllTasks();
      await getAllGroups();
    } catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.loadAllData');
      _hasError.value = UiError.unexpected;
      clearUser();
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> getAllTasks() async {
    try {
      final tasks = await loadTasks.call(userId: currentUserId);

      sortTasks(tasks);

      _allTasks
        ..clear()
        ..addAll(tasks);
      _tasks.value = tasks.where((task) => task.groupId == null).toList();
      _updateGroupsProgress();
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.getAllTasks');
      throw DomainError.unexpected;
    }
  }

  @override
  Future<void> getAllGroups() async {
    try {
      _groups.value = await loadGroups.call(currentUserId);

      _updateGroupsProgress();
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.getAllGroups');
      throw DomainError.unexpected;
    }
  }

  /// Deriva o progresso de cada grupo das tarefas já carregadas, evitando uma
  /// consulta por grupo.
  ///
  /// Checklist reutilizável que já virou o dia aparece como zerado: o reset de
  /// fato acontece ao abrir o grupo, e mostrar aqui o progresso de ontem só
  /// contaria uma história que a próxima tela vai desmentir.
  void _updateGroupsProgress() {
    _groups.value = _groups.map((group) {
      final groupTasks = _allTasks.where((task) => task.groupId == group.id);
      final completed = group.needsDailyReset()
          ? 0
          : groupTasks.where((task) => task.isDone).length;
      return group.copyWith(
        totalTasks: groupTasks.length,
        completedTasks: completed,
      );
    }).toList();
  }

  @override
  Future<void> onCreateGroup() async {
    try {
      await createGroup.call(
        userId: currentUserId,
        group: GroupEntity(
          id: '',
          name: groupNameController.text,
          description: groupDescriptionController.text,
          icon: groupIcon,
          color: groupColor,
          createdAt: DateTime.now(),
          saveCheckState: saveCheckState,
        ),
      );
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.onCreateGroup');
      throw UiError.unexpected;
    } finally {
      clearGroupFields();
      await refreshGroups();
    }
  }

  @override
  Future<void> refreshTasks() async {
    try {
      await getAllTasks();
    } catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.refreshTasks');
    }
  }

  @override
  Future<void> refreshGroups() async {
    try {
      await getAllGroups();
    } catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.refreshGroups');
    }
  }

  @override
  void clearFields() {
    clearTaskFields();
    clearGroupFields();
  }

  @override
  void onClose() {
    disposeTaskFields();
    disposeGroupFields();
    super.onClose();
  }
}
