import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';

Bindings makeGroupBinding() => _GroupBinding();

class _GroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetxGroupPresenter());
  }
}
