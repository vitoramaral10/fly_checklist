import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

void showLoadingDialog(BuildContext context) {
  final message = AppLocalizations.of(context).commonLoading;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(message, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      );
    },
  );
}
