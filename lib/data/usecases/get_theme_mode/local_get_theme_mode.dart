import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../cache/cache.dart';

class LocalGetThemeMode implements GetThemeMode {
  final LocalStorage localStorage;

  LocalGetThemeMode({required this.localStorage});

  @override
  Future<AppThemeMode> call() async {
    try {
      final value = await localStorage.getString(key: themeModeKey);

      return AppThemeMode.values.firstWhere(
        (mode) => mode.name == value,
        orElse: () => AppThemeMode.system,
      );
    } catch (e) {
      log(e.toString(), name: 'LocalGetThemeMode.call');
      return AppThemeMode.system;
    }
  }
}
