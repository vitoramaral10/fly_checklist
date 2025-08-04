import 'package:flutter/material.dart';

void showErrorDialog(
  BuildContext context,
  String message, {
  String title = 'Oops!',
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
