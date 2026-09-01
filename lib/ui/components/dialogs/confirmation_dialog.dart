import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

/// Confirmação genérica. Os textos são opcionais: o que não for informado cai
/// no rótulo padrão traduzido, resolvido a partir do [context].
Future<bool> showConfirmationDialog(
  BuildContext context, {
  String? title,
  String? content,
  String? cancelLabel,
  String? confirmLabel,
  bool destructive = false,
}) {
  final l10n = AppLocalizations.of(context);

  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title ?? l10n.confirmationDialogTitle),
      content: Text(content ?? l10n.confirmationDialogContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel ?? l10n.commonCancel),
        ),
        FilledButton.tonal(
          onPressed: () => Navigator.of(context).pop(true),
          style: destructive
              ? FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  foregroundColor: Theme.of(
                    context,
                  ).colorScheme.onErrorContainer,
                )
              : null,
          child: Text(confirmLabel ?? l10n.commonConfirm),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
