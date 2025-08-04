import 'package:flutter/material.dart';

void showSuccessDialog(
  BuildContext context,
  String message, {
  String title = 'Sucesso!',
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        icon: Icon(Icons.task_alt, color: colorScheme.primary, size: 48),
        title: Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          FilledButton.tonal(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
