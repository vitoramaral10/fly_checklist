import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../l10n/generated/app_localizations.dart';

void showAboutBottomSheet(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  if (!context.mounted) return;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (context) => _AboutBottomSheetContent(packageInfo: packageInfo),
  );
}

class _AboutBottomSheetContent extends StatelessWidget {
  const _AboutBottomSheetContent({required this.packageInfo});

  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final features = [
      (
        title: l10n.aboutFeatureReusableTitle,
        description: l10n.aboutFeatureReusableDescription,
      ),
      (
        title: l10n.aboutFeatureAviationTitle,
        description: l10n.aboutFeatureAviationDescription,
      ),
      (
        title: l10n.aboutFeatureGroupingTitle,
        description: l10n.aboutFeatureGroupingDescription,
      ),
      (
        title: l10n.aboutFeatureFlexibilityTitle,
        description: l10n.aboutFeatureFlexibilityDescription,
      ),
    ];

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withAlpha(100),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(l10n.settingsAbout, style: textTheme.headlineSmall),
              ),
              const SizedBox(height: 16),
              Text(l10n.aboutIntro),
              const SizedBox(height: 24),
              Text(l10n.aboutFeaturesTitle, style: textTheme.titleLarge),
              const SizedBox(height: 12),
              ...features.map(
                (feature) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: feature.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${feature.description}'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(l10n.aboutClosing, textAlign: TextAlign.center),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  l10n.aboutVersion(packageInfo.version),
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  l10n.aboutDeveloper,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  l10n.aboutCopyright('${DateTime.now().year}'),
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.commonClose),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
