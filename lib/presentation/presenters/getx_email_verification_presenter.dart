import 'package:fly_checklist/ui/pages/pages.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../domain/usecases/usecases.dart';

class GetxEmailVerificationPresenter extends GetxController
    implements EmailVerificationPresenter {
  final LogoutAccount logoutAccount;

  GetxEmailVerificationPresenter({required this.logoutAccount});

  @override
  Future<void> logout() {
    return logoutAccount.call();
  }
}
