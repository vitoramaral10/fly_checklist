import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

import '../data/google_signin/google_signin.dart';

class GoogleSigninAdapter implements GoogleSignInClient {
  final GoogleSignIn instance;
  final Future<void> initialization;

  GoogleSigninAdapter({required this.instance, required this.initialization});

  @override
  Future<String> signIn() async {
    try {
      await initialization;

      final googleUser = await instance.authenticate();

      final googleAuth = googleUser.authentication;

      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw GoogleSignInError.idTokenNotFound;
      }

      return idToken;
    } on GoogleSignInException catch (e) {
      log(e.toString(), name: 'GoogleSigninAdapter.signIn');
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw GoogleSignInError.userCancelled;
      }
      throw GoogleSignInError.unexpected;
    } on GoogleSignInError {
      rethrow;
    } catch (e) {
      log(e.toString(), name: 'GoogleSigninAdapter.signIn');
      throw GoogleSignInError.unexpected;
    }
  }
}
