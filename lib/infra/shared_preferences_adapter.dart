import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/cache/cache.dart';

class SharedPreferencesAdapter implements LocalStorage {
  @override
  Future<void> saveString({
    required String key,
    required String value,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      log(e.toString(), name: 'SharedPreferencesAdapter.saveString');
    }
  }

  @override
  Future<String?> getString({required String key}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      log(e.toString(), name: 'SharedPreferencesAdapter.getString');
      return null;
    }
  }
}
