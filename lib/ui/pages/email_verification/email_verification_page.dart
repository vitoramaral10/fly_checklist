import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../helpers/ui_error_translation.dart';

class EmailVerificationPage extends GetView<GetxEmailVerificationPresenter> {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.mark_email_unread_outlined,
                size: 96,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 32),
              Text(
                l10n.emailVerificationTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.emailVerificationMessage,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 48),
              FilledButton.icon(
                onPressed: () async {
                  try {
                    showLoadingDialog(context);
                    await controller.verifyEmail();
                    if (context.mounted) Navigator.of(context).pop();
                    if (context.mounted) {
                      Get.offAllNamed(Routes.dashboard);
                    }
                  } on UiError catch (e) {
                    if (context.mounted) Navigator.of(context).pop();
                    if (context.mounted) {
                      showErrorDialog(context, e.message(context));
                    }
                  }
                },
                icon: const Icon(Icons.refresh),
                label: Text(l10n.emailVerificationContinue),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () async {
                  try {
                    showLoadingDialog(context);
                    await controller.sendEmailVerification();
                    if (context.mounted) Navigator.of(context).pop();
                    if (context.mounted) {
                      showSuccessDialog(
                        context,
                        l10n.emailVerificationResentSuccess,
                      );
                    }
                  } on UiError catch (e) {
                    if (context.mounted) Navigator.of(context).pop();
                    if (context.mounted) {
                      showErrorDialog(context, e.message(context));
                    }
                  }
                },
                icon: const Icon(Icons.send_outlined),
                label: Text(l10n.emailVerificationResend),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  controller.logout();
                  Get.offAllNamed(Routes.signIn);
                },
                icon: const Icon(Icons.logout),
                label: Text(l10n.emailVerificationBackToLogin),
                style: TextButton.styleFrom(foregroundColor: colorScheme.error),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
