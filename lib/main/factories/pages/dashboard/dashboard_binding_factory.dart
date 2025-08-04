import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';

Bindings makeDashboardBinding() => _DashboardBinding();

class _DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetxDashboardPresenter());
  }
}
