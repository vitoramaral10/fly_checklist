import 'package:firebase_auth/firebase_auth.dart';

abstract class FireauthClient {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signInWithCredential({required AuthCredential credential});
  AuthCredential createCredential({required String idToken});
  Future<void> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<void> sendPasswordResetEmail({required String email});
  Future<Map<String, dynamic>?> getUser();
  Future<void> logout();
  Future<void> sendEmailVerification();
  Future<void> updatePassword(String newPassword);
}
