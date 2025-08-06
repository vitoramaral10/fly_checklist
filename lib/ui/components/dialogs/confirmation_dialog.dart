import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(
  BuildContext context, {
  String title = 'Confirmação',
  String content = 'Você tem certeza que deseja continuar?',
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Confirmar'),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
