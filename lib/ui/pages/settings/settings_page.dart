import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../helpers/ui_error_translation.dart';
import '../pages.dart';

class SettingsPage extends GetView<GetxSettingsPresenter> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: Obx(() {
        if (controller.isLoading) {
          return const SettingsLoadingPage();
        }

        if (controller.hasError != null || controller.user == null) {
          return _buildErrorState(context);
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            _buildUserProfile(context, theme),
            const SizedBox(height: 32),
            _buildSectionTitle(theme, l10n.settingsSectionAccount),
            const SizedBox(height: 8),
            _buildSettingsCard(theme, [
              _buildSettingsItem(
                theme: theme,
                icon: Icons.lock_outline_rounded,
                title: l10n.settingsChangePassword,
                onTap: () {
                  showChangePasswordBottomSheet(context);
                },
              ),
              _buildSettingsItem(
                theme: theme,
                icon: Icons.manage_accounts_outlined,
                title: l10n.settingsManageAccount,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 32),
            _buildSectionTitle(theme, l10n.settingsSectionPreferences),
            const SizedBox(height: 8),
            _buildSettingsCard(theme, [
              _buildThemeSelector(context, theme),
              _buildSettingsItem(
                theme: theme,
                icon: Icons.notifications_outlined,
                title: l10n.settingsNotifications,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 32),
            _buildSectionTitle(theme, l10n.settingsSectionOther),
            const SizedBox(height: 8),
            _buildSettingsCard(theme, [
              _buildSettingsItem(
                theme: theme,
                icon: Icons.info_outline_rounded,
                title: l10n.settingsAbout,
                onTap: () {
                  showAboutBottomSheet(context);
                },
              ),
              _buildSettingsItem(
                theme: theme,
                icon: Icons.privacy_tip_outlined,
                title: l10n.settingsPrivacyPolicy,
                onTap: () {},
              ),
              _buildSettingsItem(
                theme: theme,
                icon: Icons.description_outlined,
                title: l10n.settingsTermsOfService,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 32),
            _buildLogoutButton(theme, context),
          ],
        );
      }),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyState(
            icon: Icons.cloud_off_rounded,
            title: l10n.settingsLoadErrorTitle,
            message: (controller.hasError ?? UiError.unexpected).message(
              context,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => controller.loadAllData(),
            icon: const Icon(Icons.refresh_rounded),
            label: Text(l10n.commonRetry),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, ThemeData theme) {
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        AvatarWithShimmer(imageUrl: controller.user?.photoUrl, size: 104),
        const SizedBox(height: 16),
        Text(
          controller.user?.name ?? l10n.settingsUserFallbackName,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          controller.user?.email ?? l10n.settingsEmailUnavailable,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(ThemeData theme, List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withAlpha(100),
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsItem({
    required ThemeData theme,
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      title: Text(title, style: theme.textTheme.bodyLarge),
      subtitle: subtitle != null
          ? Text(subtitle, style: theme.textTheme.bodyMedium)
          : null,
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
      onTap: onTap,
    );
  }

  Widget _buildThemeSelector(BuildContext context, ThemeData theme) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            _themeModeIcon(controller.themeMode),
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              l10n.settingsThemeLabel,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SegmentedButton<AppThemeMode>(
            segments: const [
              ButtonSegment(
                value: AppThemeMode.light,
                icon: Icon(Icons.light_mode_outlined),
              ),
              ButtonSegment(
                value: AppThemeMode.dark,
                icon: Icon(Icons.dark_mode_outlined),
              ),
              ButtonSegment(
                value: AppThemeMode.system,
                icon: Icon(Icons.brightness_auto_outlined),
              ),
            ],
            selected: {controller.themeMode},
            showSelectedIcon: false,
            onSelectionChanged: (selection) {
              controller.setThemeMode(selection.first);
            },
          ),
        ],
      ),
    );
  }

  IconData _themeModeIcon(AppThemeMode themeMode) {
    switch (themeMode) {
      case AppThemeMode.light:
        return Icons.light_mode_outlined;
      case AppThemeMode.dark:
        return Icons.dark_mode_outlined;
      case AppThemeMode.system:
        return Icons.brightness_auto_outlined;
    }
  }

  Widget _buildLogoutButton(ThemeData theme, BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return OutlinedButton.icon(
      icon: const Icon(Icons.logout_rounded),
      label: Text(l10n.settingsLogout),
      onPressed: () async {
        try {
          await controller.logout();
          Get.offAllNamed(Routes.home);
        } on UiError catch (e) {
          log(e.toString(), name: 'SettingsPage._buildLogoutButton');

          if (context.mounted) {
            showErrorDialog(
              context,
              e.message(context),
              title: l10n.settingsLogoutErrorTitle,
            );
          }
        }
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: theme.colorScheme.error,
        side: BorderSide(color: theme.colorScheme.error.withAlpha(100)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
