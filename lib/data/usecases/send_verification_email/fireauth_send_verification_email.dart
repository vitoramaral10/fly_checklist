import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../fireauth/fireauth.dart';

class FireauthSendVerificationEmail implements SendVerificationEmail {
  final FireauthClient firebaseAuthClient;

  FireauthSendVerificationEmail({required this.firebaseAuthClient});

  @override
  Future<void> call() async {
    try {
      await firebaseAuthClient.sendEmailVerification();
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
