import '../entities/entities.dart';

abstract class GetThemeMode {
  Future<AppThemeMode> call();
}
