import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../l10n/generated/app_localizations.dart';

/// O [context] existe só para resolver os rótulos padrão: o snackbar em si é
/// exibido pelo overlay do GetX, fora da árvore desta página.
void showSuccessSnackbar(
  BuildContext context, {
  String? title,
  String? message,
}) {
  final l10n = AppLocalizations.of(context);

  Get.snackbar(
    title ?? l10n.successSnackbarTitle,
    message ?? l10n.successSnackbarMessage,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green.shade200,
    colorText: Colors.green.shade900,
  );
}
