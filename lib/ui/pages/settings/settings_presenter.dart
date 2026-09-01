import 'package:fly_checklist/domain/entities/entities.dart';

import '../../helpers/ui_error.dart';

abstract class SettingsPresenter {
  bool get isLoading;
  UserEntity? get user;
  UiError? get hasError;
  bool get showCurrentPassword;
  bool get showNewPassword;
  bool get showConfirmNewPassword;
  AppThemeMode get themeMode;

  Future<void> loadAllData();
  Future<void> loadUserData();
  Future<void> logout();
  void toggleShowCurrentPassword();
  void toggleShowNewPassword();
  void toggleShowConfirmNewPassword();
  Future<bool> changePasswordAction();
  void clearChangePasswordFields();
  Future<void> setThemeMode(AppThemeMode themeMode);
}
