import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool tonal;
  final bool expanded;
  final IconData icon;

  const AddTaskButton({
    super.key,
    required this.onPressed,
    this.label = 'Adicionar tarefa',
    this.tonal = true,
    this.expanded = false,
    this.icon = Icons.add_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final button = FilledButton.icon(
      style: tonal
          ? FilledButton.styleFrom(
              backgroundColor: scheme.secondaryContainer,
              foregroundColor: scheme.onSecondaryContainer,
            )
          : null,
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );

    if (expanded) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}
