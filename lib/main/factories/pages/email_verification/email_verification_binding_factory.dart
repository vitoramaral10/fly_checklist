import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';

Bindings makeEmailVerificationBinding() => _EmailVerificationBinding();

class _EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetxEmailVerificationPresenter());
  }
}
