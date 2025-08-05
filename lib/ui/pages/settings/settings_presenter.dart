import 'package:fly_checklist/domain/entities/entities.dart';

abstract class SettingsPresenter {
  bool get isLoading;
  UserEntity? get user;
  String? get hasError;

  Future<void> loadAllData();
  Future<void> loadUserData();
  Future<void> logout();
}
