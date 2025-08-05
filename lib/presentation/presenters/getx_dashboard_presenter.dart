import 'dart:developer';

import 'package:fly_checklist/domain/helpers/helpers.dart';
import 'package:fly_checklist/ui/helpers/helpers.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxDashboardPresenter extends GetxController
    implements DashboardPresenter {
  final GetUser getUser;

  GetxDashboardPresenter({required this.getUser});

  final _isLoading = true.obs;
  final _hasError = Rxn<String>();
  final _user = Rxn<UserEntity>();

  @override
  bool get isLoading => _isLoading.value;
  @override
  String? get hasError => _hasError.value;
  @override
  UserEntity? get user => _user.value;

  @override
  Future<void> onInit() async {
    super.onInit();

    await loadAllData();
    _isLoading.value = false;
  }

  @override
  Future<void> loadAllData() async {
    try {
      await loadUser();
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxDashboardPresenter.loadAllData');
      _hasError.value = UiError.unexpected.message;
      _user.value = null;
    }
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
}
