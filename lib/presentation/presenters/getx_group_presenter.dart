import 'dart:developer';

import 'package:fly_checklist/domain/usecases/usecases.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxGroupPresenter extends GetxController implements GroupPresenter {
  final GetUser getUser;
  final GetGroup getGroup;
  final LoadTasks loadTasks;

  GetxGroupPresenter({
    required this.getUser,
    required this.getGroup,
    required this.loadTasks,
  });

  final _isLoading = true.obs;
  final _hasError = Rxn<String>();
  final _group = Rxn<GroupEntity>();
  final _tasks = <TaskEntity>[].obs;
  final _user = Rxn<UserEntity>();

  @override
  GroupEntity? get group => _group.value;
  @override
  bool get isLoading => _isLoading.value;
  @override
  String? get hasError => _hasError.value;
  @override
  List<TaskEntity> get tasks => _tasks;
  @override
  UserEntity? get user => _user.value;

  @override
  Future<void> onInit() async {
    super.onInit();

    await loadUser();
    await loadGroup();

    _isLoading.value = false;
    _hasError.value = null;
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
  Future<void> loadGroup() async {
    try {
      final group = await getGroup.call(
        userId: user!.uid,
        groupId: Get.parameters['id']!,
      );
      _group.value = group;
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.loadGroup');
      throw DomainError.unexpected;
    }
  }

  @override
  Future<void> getAllTasks() async {
    try {
      final tasks = await loadTasks.call(userId: user!.uid, groupId: group!.id);

      _tasks.value = tasks;
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxGroupPresenter.getAllTasks');
      throw DomainError.unexpected;
    }
  }
}
