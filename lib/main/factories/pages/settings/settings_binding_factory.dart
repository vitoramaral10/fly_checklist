import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings makeSettingsBinding() => _SettingsBinding();

class _SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxSettingsPresenter(
        getUser: makeFireauthGetUser(),
        logoutAccount: makeFireauthLogoutAccount(),
        loginWithEmail: makeFireauthLoginWithEmail(),
        changePassword: makeFireauthChangePassword(),
      ),
    );
  }
}
