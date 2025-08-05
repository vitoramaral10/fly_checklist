import 'dart:developer';

import 'package:flutter/material.dart';
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
  final LoginWithEmail loginWithEmail;
  final ChangePassword changePassword;

  GetxSettingsPresenter({
    required this.getUser,
    required this.logoutAccount,
    required this.loginWithEmail,
    required this.changePassword,
  });

  final formChangePasswordKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final _isLoading = true.obs;
  final _user = Rxn<UserEntity?>();
  final _hasError = Rxn<String>();
  final _showCurrentPassword = false.obs;
  final _showNewPassword = false.obs;
  final _showConfirmNewPassword = false.obs;

  @override
  bool get isLoading => _isLoading.value;
  @override
  UserEntity? get user => _user.value;
  @override
  String? get hasError => _hasError.value;
  @override
  bool get showCurrentPassword => _showCurrentPassword.value;
  @override
  bool get showNewPassword => _showNewPassword.value;
  @override
  bool get showConfirmNewPassword => _showConfirmNewPassword.value;

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

  @override
  void toggleShowCurrentPassword() {
    _showCurrentPassword.value = !_showCurrentPassword.value;
  }

  @override
  void toggleShowNewPassword() {
    _showNewPassword.value = !_showNewPassword.value;
  }

  @override
  void toggleShowConfirmNewPassword() {
    _showConfirmNewPassword.value = !_showConfirmNewPassword.value;
  }

  @override
  Future<void> changePasswordAction() async {
    if (formChangePasswordKey.currentState!.validate()) {
      try {
        await loginWithEmail.call(
          email: _user.value!.email,
          password: currentPasswordController.text,
        );

        await changePassword.call(newPassword: newPasswordController.text);

        Get.offAllNamed(Routes.home);
      } on DomainError catch (e) {
        log(e.toString(), name: 'GetxSettingsPresenter.changePassword');

        throw UiError.unexpected;
      }
    }
  }
}
