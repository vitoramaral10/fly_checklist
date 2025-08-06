import 'package:get/get.dart';

void showErrorSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Get.theme.colorScheme.errorContainer,
    colorText: Get.theme.colorScheme.onErrorContainer,
  );
}
