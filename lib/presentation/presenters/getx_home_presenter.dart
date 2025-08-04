import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../../main/routes.dart';
import '../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final GetUser getUser;

  GetxHomePresenter({required this.getUser});

  final _enableButtons = false.obs;

  @override
  bool get enableButtons => _enableButtons.value;

  @override
  void onInit() {
    super.onInit();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 1));
    await checkIsAuthenticated();
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

  @override
  Future<void> checkIsAuthenticated() async {
    try {
      final user = await getUser.call();

      if (user.emailVerified == true) {
        Get.offAllNamed(Routes.dashboard);
      } else {
        Get.offAllNamed(Routes.emailVerification);
      }
    } catch (e) {
      log(e.toString(), name: 'GetxHomePresenter.checkIsAuthenticated');
      _enableButtons.value = true;
    }
  }
}
