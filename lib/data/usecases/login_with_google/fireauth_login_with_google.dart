import 'dart:developer';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../fireauth/fireauth.dart';
import '../../google_signin/google_signin.dart';

class FireauthLoginWithGoogle implements LoginWithGoogle {
  final FireauthClient firebaseAuthClient;
  final GoogleSignInClient googleSignInClient;

  FireauthLoginWithGoogle({
    required this.firebaseAuthClient,
    required this.googleSignInClient,
  });

  @override
  Future<void> call() async {
    try {
      final idToken = await googleSignInClient.signIn();

      final credential = firebaseAuthClient.createCredential(idToken: idToken);

      await firebaseAuthClient.signInWithCredential(credential: credential);
    } on FireauthError catch (e) {
      log(e.toString(), name: 'FireauthLoginWithGoogle.call.fireauthError');
      throw DomainError.unexpected;
    } on GoogleSignInError catch (e) {
      log(e.toString(), name: 'FireauthLoginWithGoogle.call.googleSignInError');
      throw DomainError.unexpected;
    } catch (e) {
      log(e.toString(), name: 'FireauthLoginWithGoogle.call.unexpected');
      throw DomainError.unexpected;
    }
  }
}
