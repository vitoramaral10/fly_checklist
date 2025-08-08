import 'package:flutter/material.dart';

class AddGroupButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool tonal;
  final bool expanded;
  final IconData icon;

  const AddGroupButton({
    super.key,
    required this.onPressed,
    this.label = 'Adicionar grupo',
    this.tonal = true,
    this.expanded = false,
    this.icon = Icons.group_add_rounded,
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
