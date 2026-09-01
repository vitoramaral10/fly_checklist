import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../l10n/generated/app_localizations.dart';

/// O [context] existe só para resolver os rótulos padrão e o brightness
/// atual: o snackbar em si é exibido pelo overlay do GetX, fora da árvore
/// desta página.
void showSuccessSnackbar(
  BuildContext context, {
  String? title,
  String? message,
}) {
  final l10n = AppLocalizations.of(context);

  // O Material 3 não define um papel de cor para "sucesso", então geramos um
  // verde harmonizado a partir do brightness atual — mesma técnica de
  // `ColorScheme.fromSeed` usada no tema do app, garantindo contraste nos
  // dois temas em vez de um tom fixo de light mode.
  final successScheme = ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Theme.of(context).brightness,
  );

  Get.snackbar(
    title ?? l10n.successSnackbarTitle,
    message ?? l10n.successSnackbarMessage,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: successScheme.primaryContainer,
    colorText: successScheme.onPrimaryContainer,
  );
}
