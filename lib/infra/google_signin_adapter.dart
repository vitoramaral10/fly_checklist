import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

import '../data/google_signin/google_signin.dart';

class GoogleSigninAdapter implements GoogleSignInClient {
  final GoogleSignIn instance;

  GoogleSigninAdapter({required this.instance});

  @override
  Future<String> signIn() async {
    try {
      final googleUser = await instance.authenticate();

      final googleAuth = googleUser.authentication;

      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw GoogleSignInError.idTokenNotFound;
      }

      return idToken;
    } on GoogleSignInException catch (e) {
      log(e.toString(), name: 'GoogleSigninAdapter.signIn');
      throw GoogleSignInError.unexpected;
    } catch (e) {
      log(e.toString(), name: 'GoogleSigninAdapter.signIn');
      throw GoogleSignInError.unexpected;
    }
  }
}
