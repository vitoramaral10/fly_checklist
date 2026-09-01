import 'dart:developer';

import 'package:fly_checklist/domain/usecases/usecases.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxGroupPresenter extends GetxController
    with UserManager, TaskManager, GroupManager
    implements GroupPresenter {
  @override
  final GetUser getUser;
  final GetGroup getGroup;
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
  @override
  final UpdateGroup updateGroup;
  @override
  final DeleteGroup deleteGroup;
  final ResetGroupTasks resetGroupTasks;

  GetxGroupPresenter({
    required this.getUser,
    required this.getGroup,
    required this.loadTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
    required this.scheduleTaskReminder,
    required this.cancelTaskReminder,
    required this.updateGroup,
    required this.deleteGroup,
    required this.resetGroupTasks,
  });

  final _isLoading = true.obs;
  final _hasError = Rxn<UiError>();
  final _group = Rxn<GroupEntity>();
  final _tasks = <TaskEntity>[].obs;

  @override
  GroupEntity? get group => _group.value;
  @override
  bool get isLoading => _isLoading.value;
  @override
  UiError? get hasError => _hasError.value;
  @override
  List<TaskEntity> get tasks => _tasks;

  /// O seletor de grupo da tarefa só oferece o grupo aberto, além da opção de
  /// deixá-la sem grupo.
  @override
  List<GroupEntity> get groups {
    final group = _group.value;
    return group != null ? [group] : const [];
  }

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
      await loadGroup();
      final didReset = await _resetChecklistIfNeeded();
      await getAllTasks();

      // O reset desmarca tarefas sem passar por toggleTaskCompletion, então
      // os lembretes das que ainda vencem no futuro precisam voltar.
      if (didReset) await syncTaskReminders(_tasks);
    } catch (e) {
      log(e.toString(), name: 'GetxGroupPresenter.loadAllData');
      _hasError.value = UiError.unexpected;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> loadGroup() async {
    final groupId = _group.value?.id ?? Get.parameters['id'];

    if (groupId == null || groupId.isEmpty) {
      log(
        'Rota do grupo aberta sem o parâmetro "id".',
        name: 'GetxGroupPresenter.loadGroup',
      );
      throw DomainError.unexpected;
    }

    try {
      final group = await getGroup.call(
        userId: currentUserId,
        groupId: groupId,
      );
      _group.value = group;
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxGroupPresenter.loadGroup');
      throw DomainError.unexpected;
    }
  }

  @override
  Future<void> getAllTasks() async {
    try {
      final tasks = await loadTasks.call(
        userId: currentUserId,
        groupId: group!.id,
      );

      sortTasks(tasks);

      _tasks.value = tasks;
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxGroupPresenter.getAllTasks');
      throw DomainError.unexpected;
    }
  }

  /// Reset por virada de dia: um checklist reutilizável aberto num dia
  /// posterior ao último uso volta todo desmarcado antes de aparecer na tela.
  ///
  /// Falha aqui não derruba a página: o grupo continua sendo exibido com os
  /// checks antigos e a tentativa se repete na próxima abertura, já que
  /// `lastResetAt` só avança quando o reset conclui.
  /// Devolve se o reset chegou a acontecer, para que quem chamou saiba que o
  /// estado das tarefas mudou por fora dos fluxos normais.
  Future<bool> _resetChecklistIfNeeded() async {
    final group = _group.value;

    if (group == null || !group.needsDailyReset()) return false;

    try {
      _group.value = await resetGroupTasks.call(
        userId: currentUserId,
        group: group,
      );
      return true;
    } catch (e) {
      log(e.toString(), name: 'GetxGroupPresenter._resetChecklistIfNeeded');
      return false;
    }
  }

  @override
  Future<void> onResetGroupTasks() async {
    final group = _group.value;

    if (group == null) return;

    try {
      _group.value = await resetGroupTasks.call(
        userId: currentUserId,
        group: group,
      );
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxGroupPresenter.onResetGroupTasks');
      throw UiError.unexpected;
    } finally {
      await refreshTasks();
      // O reset desmarca todas as tarefas do grupo; as que ainda vencem no
      // futuro voltam a merecer lembrete.
      await syncTaskReminders(_tasks);
    }
  }

  @override
  Future<void> refreshTasks() async {
    try {
      await getAllTasks();
    } catch (e) {
      log(e.toString(), name: 'GetxGroupPresenter.refreshTasks');
    }
  }

  @override
  Future<void> refreshGroups() async {
    try {
      await loadGroup();
    } catch (e) {
      log(e.toString(), name: 'GetxGroupPresenter.refreshGroups');
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
