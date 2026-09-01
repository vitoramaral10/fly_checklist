import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../cache/cache.dart';

class LocalSaveThemeMode implements SaveThemeMode {
  final LocalStorage localStorage;

  LocalSaveThemeMode({required this.localStorage});

  @override
  Future<void> call({required AppThemeMode themeMode}) async {
    try {
      await localStorage.saveString(key: themeModeKey, value: themeMode.name);
    } catch (e) {
      log(e.toString(), name: 'LocalSaveThemeMode.call');
    }
  }
}
