import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const GoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FilledButton.icon(
      onPressed: onPressed,
      icon: Image.asset('assets/images/google.png', height: 24),
      label: Text(
        AppLocalizations.of(context).signInWithGoogle,
        style: const TextStyle(fontSize: 16),
      ),
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colorScheme.outline.withAlpha(100)),
        ),
      ),
    );
  }
}
