import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';

class EmailVerificationPage extends GetView<GetxEmailVerificationPresenter> {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                'Verifique seu e-mail',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Enviamos um link de verificação para o seu e-mail. Por favor, verifique sua caixa de entrada e siga as instruções para ativar sua conta.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 48),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
                label: const Text('Já verifiquei, continuar'),
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
                        'E-mail de verificação reenviado com sucesso. Por favor, verifique sua caixa de entrada.',
                      );
                    }
                  } on UiError catch (e) {
                    if (context.mounted) Navigator.of(context).pop();
                    if (context.mounted) showErrorDialog(context, e.message);
                  }
                },
                icon: const Icon(Icons.send_outlined),
                label: const Text('Reenviar e-mail de verificação'),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  controller.logout();
                  Get.offAllNamed(Routes.signIn);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Voltar para o login'),
                style: TextButton.styleFrom(foregroundColor: colorScheme.error),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
