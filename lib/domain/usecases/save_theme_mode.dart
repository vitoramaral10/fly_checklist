import '../entities/entities.dart';

abstract class SaveThemeMode {
  Future<void> call({required AppThemeMode themeMode});
}
