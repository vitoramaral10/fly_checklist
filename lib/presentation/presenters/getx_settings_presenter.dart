import 'dart:developer';

import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../main/routes.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxSettingsPresenter extends GetxController
    implements SettingsPresenter {
  final GetUser getUser;
  final LogoutAccount logoutAccount;

  GetxSettingsPresenter({required this.getUser, required this.logoutAccount});

  final _isLoading = true.obs;
  final _user = Rxn<UserEntity?>();
  final _hasError = Rxn<String>();

  @override
  bool get isLoading => _isLoading.value;

  @override
  UserEntity? get user => _user.value;

  @override
  String? get hasError => _hasError.value;

  @override
  Future<void> onInit() async {
    super.onInit();

    await loadAllData();
    _isLoading.value = false;
  }

  @override
  Future<void> loadAllData() async {
    try {
      await loadUserData();
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxSettingsPresenter.loadAllData');
      _hasError.value = UiError.unexpected.message;
      _user.value = null;
    }
  }

  @override
  Future<void> loadUserData() async {
    try {
      final user = await getUser.call();
      _user.value = user;
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxSettingsPresenter.loadUser');
      throw DomainError.unexpected;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await logoutAccount.call();
      Get.offAllNamed(Routes.home);
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxSettingsPresenter.logout');
      throw UiError.unexpected;
    }
  }
}
