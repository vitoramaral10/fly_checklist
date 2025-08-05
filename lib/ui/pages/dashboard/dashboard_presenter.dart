import '../../../domain/entities/entities.dart';

abstract class DashboardPresenter {
  bool get isLoading;
  String? get hasError;
  UserEntity? get user;

  Future<void> loadAllData();
  Future<void> loadUser();
}
