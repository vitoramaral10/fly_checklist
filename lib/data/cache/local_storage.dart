/// Chave usada para persistir a preferência de tema do usuário.
const themeModeKey = 'theme_mode';

abstract class LocalStorage {
  Future<void> saveString({required String key, required String value});
  Future<String?> getString({required String key});
}
