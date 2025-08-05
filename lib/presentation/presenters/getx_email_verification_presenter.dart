import 'dart:developer';

import 'package:fly_checklist/ui/pages/pages.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';

class GetxEmailVerificationPresenter extends GetxController
    implements EmailVerificationPresenter {
  final LogoutAccount logoutAccount;
  final GetUser getUser;
  final SendVerificationEmail sendVerificationEmail;

  GetxEmailVerificationPresenter({
    required this.logoutAccount,
    required this.getUser,
    required this.sendVerificationEmail,
  });

  @override
  Future<void> logout() {
    return logoutAccount.call();
  }

  @override
  Future<void> verifyEmail() async {
    try {
      final user = await getUser.call();

      if (!user.emailVerified) {
        throw UiError.emailNotVerified;
      }
    } on DomainError catch (e) {
      log(e.toString(), name: 'VerifyEmail');
      throw UiError.unexpected;
    } on UiError {
      rethrow;
    } catch (e) {
      log(e.toString(), name: 'VerifyEmail');
      throw UiError.unexpected;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      return await sendVerificationEmail.call();
    } on DomainError catch (e) {
      log(e.toString(), name: 'SendEmailVerification');
      throw UiError.unexpected;
    }
  }
}
