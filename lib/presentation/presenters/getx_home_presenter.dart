import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  @override
  void onInit() {
    super.onInit();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.onClose();
  }
}
