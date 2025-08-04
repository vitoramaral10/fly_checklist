import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings makeHomeBinding() => _HomeBinding();

class _HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetxHomePresenter(getUser: makeFireauthGetUser()));
  }
}
