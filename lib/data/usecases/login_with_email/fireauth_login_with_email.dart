import 'dart:developer';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../fireauth/fireauth.dart';

class FireauthLoginWithEmail implements LoginWithEmail {
  final FireauthClient firebaseAuthClient;

  FireauthLoginWithEmail({required this.firebaseAuthClient});

  @override
  Future<void> call({required String email, required String password}) async {
    try {
      await firebaseAuthClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FireauthError catch (e) {
      log(e.toString(), name: 'FireauthLoginWithEmail.call.fireauthError');

      switch (e) {
        case FireauthError.invalidCredential:
          throw DomainError.invalidCredential;
        default:
          throw DomainError.unexpected;
      }
    } catch (e) {
      log(e.toString(), name: 'FireauthLoginWithEmail.call.unexpected');
      throw DomainError.unexpected;
    }
  }
}
