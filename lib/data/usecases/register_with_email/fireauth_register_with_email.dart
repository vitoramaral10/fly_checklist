import 'dart:developer';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../fireauth/fireauth.dart';
import '../../google_signin/google_signin.dart';

class FireauthRegisterWithEmail implements RegisterWithEmail {
  final FireauthClient firebaseAuthClient;

  FireauthRegisterWithEmail({required this.firebaseAuthClient});

  @override
  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuthClient.createUserWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
    } on FireauthError catch (e) {
      log(e.toString(), name: 'FireauthRegisterWithGoogle.call.fireauthError');

      switch (e) {
        case FireauthError.emailAlreadyInUse:
          throw DomainError.emailInUse;
        case FireauthError.invalidEmail:
          throw DomainError.invalidEmail;
        case FireauthError.operationNotAllowed:
          throw DomainError.operationNotAllowed;
        case FireauthError.weakPassword:
          throw DomainError.weakPassword;
        default:
          throw DomainError.unexpected;
      }
    } on GoogleSignInError catch (e) {
      log(
        e.toString(),
        name: 'FireauthRegisterWithGoogle.call.googleSignInError',
      );
      throw DomainError.unexpected;
    } catch (e) {
      log(e.toString(), name: 'FireauthRegisterWithGoogle.call.unexpected');
      throw DomainError.unexpected;
    }
  }
}
