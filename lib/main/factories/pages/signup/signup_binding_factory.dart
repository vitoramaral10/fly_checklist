import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings makeSignUpBinding() => _SignUpBinding();

class _SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxSignUpPresenter(
        registerWithEmail: makeFireauthRegisterWithEmail(),
        registerWithGoogle: makeFireauthRegisterWithGoogle(),
        sendVerificationEmail: makeFireauthSendVerificationEmail(),
      ),
    );
  }
}
