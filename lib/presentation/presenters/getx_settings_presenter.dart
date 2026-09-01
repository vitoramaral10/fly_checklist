import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxSettingsPresenter extends GetxController
    implements SettingsPresenter {
  final GetUser getUser;
  final LogoutAccount logoutAccount;
  final LoginWithEmail loginWithEmail;
  final ChangePassword changePassword;
  final GetThemeMode getThemeMode;
  final SaveThemeMode saveThemeMode;

  GetxSettingsPresenter({
    required this.getUser,
    required this.logoutAccount,
    required this.loginWithEmail,
    required this.changePassword,
    required this.getThemeMode,
    required this.saveThemeMode,
  });

  final formChangePasswordKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final _isLoading = true.obs;
  final _user = Rxn<UserEntity?>();
  final _hasError = Rxn<UiError>();
  final _showCurrentPassword = false.obs;
  final _showNewPassword = false.obs;
  final _showConfirmNewPassword = false.obs;
  final _themeMode = AppThemeMode.system.obs;

  @override
  bool get isLoading => _isLoading.value;
  @override
  UserEntity? get user => _user.value;
  @override
  UiError? get hasError => _hasError.value;
  @override
  bool get showCurrentPassword => _showCurrentPassword.value;
  @override
  bool get showNewPassword => _showNewPassword.value;
  @override
  bool get showConfirmNewPassword => _showConfirmNewPassword.value;
  @override
  AppThemeMode get themeMode => _themeMode.value;

  @override
  Future<void> onInit() async {
    super.onInit();

    _themeMode.value = await getThemeMode.call();
    await loadAllData();
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }

  @override
  Future<void> loadAllData() async {
    _hasError.value = null;
    try {
      await loadUserData();
    } catch (e) {
      log(e.toString(), name: 'GetxSettingsPresenter.loadAllData');
      _hasError.value = UiError.unexpected;
      _user.value = null;
    } finally {
      _isLoading.value = false;
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
  Future<bool> changePasswordAction() async {
    if (!(formChangePasswordKey.currentState?.validate() ?? false)) {
      return false;
    }

    try {
      await loginWithEmail.call(
        email: _user.value!.email,
        password: currentPasswordController.text,
      );

      await changePassword.call(newPassword: newPasswordController.text);

      clearChangePasswordFields();

      return true;
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxSettingsPresenter.changePassword');

      throw UiError.unexpected;
    }
  }

  @override
  void clearChangePasswordFields() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
    formChangePasswordKey.currentState?.reset();
  }

  @override
  Future<void> setThemeMode(AppThemeMode themeMode) async {
    _themeMode.value = themeMode;
    Get.changeThemeMode(themeMode.toFlutterThemeMode);
    await saveThemeMode.call(themeMode: themeMode);
  }
}

extension on AppThemeMode {
  ThemeMode get toFlutterThemeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
