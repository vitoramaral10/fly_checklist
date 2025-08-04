import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';

Bindings makeSignUpBinding() => _SignUpBinding();

class _SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => GetxSignUpPresenter());
  }
}
