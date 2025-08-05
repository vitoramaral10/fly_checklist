import 'dart:developer';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../fireauth/fireauth.dart';

class FireauthChangePassword implements ChangePassword {
  final FireauthClient firebaseAuth;

  FireauthChangePassword({required this.firebaseAuth});

  @override
  Future<void> call({required String newPassword}) async {
    try {
      await firebaseAuth.updatePassword(newPassword);
    } on FireauthError catch (e) {
      log(e.toString(), name: 'FireauthChangePassword');
      throw DomainError.unexpected;
    } catch (e) {
      log(e.toString(), name: 'FireauthChangePassword');
      throw DomainError.unexpected;
    }
  }
}
