import 'package:fly_checklist/domain/entities/entities.dart';

abstract class SettingsPresenter {
  bool get isLoading;
  UserEntity? get user;
  String? get hasError;
  bool get showCurrentPassword;
  bool get showNewPassword;
  bool get showConfirmNewPassword;

  Future<void> loadAllData();
  Future<void> loadUserData();
  Future<void> logout();
  void toggleShowCurrentPassword();
  void toggleShowNewPassword();
  void toggleShowConfirmNewPassword();
  Future<void> changePasswordAction();
}
