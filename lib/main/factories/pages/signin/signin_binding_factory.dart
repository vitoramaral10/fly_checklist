import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings makeSignInBinding() => _SignInBinding();

class _SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxSignInPresenter(
        loginWithEmail: makeFireauthLoginWithEmail(),
        loginWithGoogle: makeFireauthLoginWithGoogle(),
        recoveryPassword: makeFireauthRecoveryPassword(),
        checkEmailVerification: makeFireauthCheckEmailVerification(),
      ),
    );
  }
}
