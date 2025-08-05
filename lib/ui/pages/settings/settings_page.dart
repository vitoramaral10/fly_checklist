import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../pages.dart';

class SettingsPage extends GetView<GetxSettingsPresenter> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Obx(() {
        if (controller.isLoading) {
          return const SettingsLoadingPage();
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            _buildUserProfile(theme),
            const SizedBox(height: 32),
            _buildSectionTitle(theme, 'Conta'),
            const SizedBox(height: 8),
            _buildSettingsCard(theme, [
              _buildSettingsItem(
                theme: theme,
                icon: Icons.lock_outline_rounded,
                title: 'Alterar Senha',
                onTap: () {
                  showChangePasswordBottomSheet(context);
                },
              ),
              _buildSettingsItem(
                theme: theme,
                icon: Icons.manage_accounts_outlined,
                title: 'Gerenciar Conta',
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 32),
            _buildSectionTitle(theme, 'Preferências'),
            const SizedBox(height: 8),
            _buildSettingsCard(theme, [
              _buildThemeSwitch(theme),
              _buildSettingsItem(
                theme: theme,
                icon: Icons.notifications_outlined,
                title: 'Notificações',
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 32),
            _buildSectionTitle(theme, 'Outros'),
            const SizedBox(height: 8),
            _buildSettingsCard(theme, [
              _buildSettingsItem(
                theme: theme,
                icon: Icons.info_outline_rounded,
                title: 'Sobre o App',
                onTap: () {
                  showAboutBottomSheet(context);
                },
              ),
              _buildSettingsItem(
                theme: theme,
                icon: Icons.privacy_tip_outlined,
                title: 'Política de Privacidade',
                onTap: () {},
              ),
              _buildSettingsItem(
                theme: theme,
                icon: Icons.description_outlined,
                title: 'Termos de Serviço',
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

  Widget _buildUserProfile(ThemeData theme) {
    return Column(
      children: [
        (controller.user?.photoUrl == null)
            ? CircleAvatar(
                radius: 52,
                backgroundColor: theme.colorScheme.secondary,
                child: Icon(
                  Icons.person_rounded,
                  color: theme.colorScheme.onSecondary,
                  size: 52,
                ),
              )
            : CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(controller.user!.photoUrl!),
              ),
        const SizedBox(height: 16),
        Text(
          controller.user?.name ?? 'Usuário',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          controller.user?.email ?? 'Email não disponível',
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

  Widget _buildThemeSwitch(ThemeData theme) {
    // TODO: Lógica para trocar o tema
    final isDarkMode = theme.brightness == Brightness.dark;
    return SwitchListTile(
      title: Text('Tema Escuro', style: theme.textTheme.bodyLarge),
      value: isDarkMode,
      onChanged: (value) {
        // TODO: Implementar a troca de tema
      },
      secondary: Icon(
        isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildLogoutButton(ThemeData theme, BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.logout_rounded),
      label: const Text('Sair da Conta'),
      onPressed: () async {
        try {
          await controller.logout();
        } on UiError catch (e) {
          log(e.toString(), name: 'SettingsPage._buildLogoutButton');

          if (context.mounted) {
            showErrorDialog(context, e.message, title: 'Erro ao Sair');
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
