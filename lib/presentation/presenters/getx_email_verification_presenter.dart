import 'dart:developer';

import 'package:fly_checklist/ui/pages/pages.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';

class GetxEmailVerificationPresenter extends GetxController
    implements EmailVerificationPresenter {
  final LogoutAccount logoutAccount;
  final SendVerificationEmail sendVerificationEmail;

  GetxEmailVerificationPresenter({
    required this.logoutAccount,
    required this.sendVerificationEmail,
  });

  @override
  Future<void> logout() {
    return logoutAccount.call();
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
