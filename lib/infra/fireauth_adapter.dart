import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../data/fireauth/fireauth.dart';

class FireauthAdapter implements FireauthClient {
  @override
  Future<void> signInWithCredential({
    required AuthCredential credential,
  }) async {
    try {
      final user = await FirebaseAuth.instance.signInWithCredential(credential);

      if (user.user == null) {
        throw FireauthError.unexpected;
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'FireauthAdapter.signInWithCredential');
      throw FireauthError.unexpected;
    } catch (e) {
      log(
        e.toString(),
        name: 'FireauthAdapter.signInWithCredential.unexpected',
      );
      throw FireauthError.unexpected;
    }
  }

  @override
  AuthCredential createCredential({required String idToken}) {
    try {
      return GoogleAuthProvider.credential(idToken: idToken);
    } catch (e) {
      throw FireauthError.unexpected;
    }
  }
}
