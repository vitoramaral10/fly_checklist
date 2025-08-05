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

  @override
  Future<void> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await user.user?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'FireauthAdapter.createUserWithEmailAndPassword');

      switch (e.code) {
        case 'email-already-in-use':
          throw FireauthError.emailAlreadyInUse;
        case 'invalid-email':
          throw FireauthError.invalidEmail;
        case 'operation-not-allowed':
          throw FireauthError.operationNotAllowed;
        case 'weak-password':
          throw FireauthError.weakPassword;
        default:
          throw FireauthError.unexpected;
      }
    } catch (e) {
      log(
        e.toString(),
        name: 'FireauthAdapter.createUserWithEmailAndPassword.unexpected',
      );
      throw FireauthError.unexpected;
    }
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user == null) {
        throw FireauthError.unexpected;
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'FireauthAdapter.signInWithEmailAndPassword');

      switch (e.code) {
        case 'invalid-credential':
          throw FireauthError.invalidCredential;
        case 'user-not-found':
          throw FireauthError.invalidCredential;
        case 'wrong-password':
          throw FireauthError.invalidCredential;
        default:
          throw FireauthError.unexpected;
      }
    } catch (e) {
      log(
        e.toString(),
        name: 'FireauthAdapter.signInWithEmailAndPassword.unexpected',
      );
      throw FireauthError.unexpected;
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'FireauthAdapter.sendPasswordResetEmail');

      switch (e.code) {
        case 'invalid-email':
          throw FireauthError.invalidEmail;
        default:
          throw FireauthError.unexpected;
      }
    } catch (e) {
      log(
        e.toString(),
        name: 'FireauthAdapter.sendPasswordResetEmail.unexpected',
      );
      throw FireauthError.unexpected;
    }
  }

  @override
  Future<Map<String, dynamic>?> getUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Força o reload das informações do usuário para garantir dados atualizados
        await user.reload();
        // Pega o usuário atualizado após o reload
        final updatedUser = FirebaseAuth.instance.currentUser;

        return updatedUser != null
            ? {
                'uid': updatedUser.uid,
                'email': updatedUser.email,
                'displayName': updatedUser.displayName,
                'photoURL': updatedUser.photoURL,
                'emailVerified': updatedUser.emailVerified,
              }
            : null;
      }

      return null;
    } catch (e) {
      log(e.toString(), name: 'FireauthAdapter.getUser.unexpected');
      throw FireauthError.unexpected;
    }
  }

  @override
  Future<void> logout() {
    try {
      return FirebaseAuth.instance.signOut();
    } catch (e) {
      log(e.toString(), name: 'FireauthAdapter.logout.unexpected');
      throw FireauthError.unexpected;
    }
  }

  @override
  Future<void> sendEmailVerification() {
    try {
      return FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (e) {
      log(
        e.toString(),
        name: 'FireauthAdapter.sendEmailVerification.unexpected',
      );
      throw FireauthError.unexpected;
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw FireauthError.unexpected;
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'FireauthAdapter.updatePassword');
      throw FireauthError.unexpected;
    } catch (e) {
      log(e.toString(), name: 'FireauthAdapter.updatePassword.unexpected');
      throw FireauthError.unexpected;
    }
  }
}
