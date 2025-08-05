import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings makeEmailVerificationBinding() => _EmailVerificationBinding();

class _EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxEmailVerificationPresenter(
        logoutAccount: makeFireauthLogoutAccount(),
        getUser: makeFireauthGetUser(),
        sendVerificationEmail: makeFireauthSendVerificationEmail(),
      ),
    );
  }
}
