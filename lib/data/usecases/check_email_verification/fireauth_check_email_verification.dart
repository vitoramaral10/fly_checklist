import '../../../domain/usecases/usecases.dart';
import '../../fireauth/fireauth.dart';

class FireauthCheckEmailVerification implements CheckEmailVerification {
  final FireauthClient firebaseAuthClient;

  FireauthCheckEmailVerification({required this.firebaseAuthClient});

  @override
  bool call() {
    try {
      final user = firebaseAuthClient.getUser();

      if (user == null) {
        return false; // User not found
      }

      return user['emailVerified'] ?? false;
    } catch (e) {
      // Handle error, e.g., log it or rethrow
      return false;
    }
  }
}
