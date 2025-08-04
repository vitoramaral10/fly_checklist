import 'package:firebase_auth/firebase_auth.dart';

abstract class FireauthClient {
  Future<void> signInWithCredential({required AuthCredential credential});
  AuthCredential createCredential({required String idToken});
}
