import 'dart:developer';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../fireauth/fireauth.dart';

class FireauthRecoveryPassword implements RecoveryPassword {
  final FireauthClient firebaseAuthClient;

  FireauthRecoveryPassword({required this.firebaseAuthClient});

  @override
  Future<void> call({required String email}) async {
    try {
      await firebaseAuthClient.sendPasswordResetEmail(email: email);
    } on FireauthError catch (e) {
      log(e.toString(), name: 'FireauthRecoveryPassword.call.fireauthError');

      switch (e) {
        case FireauthError.invalidCredential:
          throw DomainError.invalidEmail;
        default:
          throw DomainError.unexpected;
      }
    } catch (e) {
      log(e.toString(), name: 'FireauthRecoveryPassword.call.unexpected');
      throw DomainError.unexpected;
    }
  }
}
