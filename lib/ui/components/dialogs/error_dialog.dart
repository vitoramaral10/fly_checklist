import 'package:flutter/material.dart';

void showErrorDialog(
  BuildContext context,
  String message, {
  String title = 'Ocorreu um erro',
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: const Icon(Icons.error_outline),
        title: Text(title),
        content: Text(message, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Entendi'),
          ),
        ],
      );
    },
  );
}
