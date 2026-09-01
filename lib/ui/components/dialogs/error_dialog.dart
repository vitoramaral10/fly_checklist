import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

void showErrorDialog(BuildContext context, String message, {String? title}) {
  final l10n = AppLocalizations.of(context);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: const Icon(Icons.error_outline),
        title: Text(title ?? l10n.errorDialogTitle),
        content: Text(message, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(l10n.commonGotIt),
          ),
        ],
      );
    },
  );
}
