import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../components/components.dart';
import '../../../helpers/helpers.dart';

Future<void> showForgotPasswordBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const ForgotPasswordBottomSheet();
    },
  );
}

class ForgotPasswordBottomSheet extends GetView<GetxSignInPresenter> {
  const ForgotPasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: controller.formRecoverKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withAlpha(100),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Text('Recuperar Senha', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 16),
                Text(
                  'Insira seu e-mail para receber instruções de recuperação.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: controller.emailRecoveryController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail.';
                    }
                    if (GetUtils.isEmail(value) == false) {
                      return 'E-mail inválido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      try {
                        showLoadingDialog(context);
                        await controller.recoverPassword();
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) Navigator.of(context).pop();
                      } on UiError catch (e) {
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) {
                          showErrorDialog(context, e.message);
                        }
                      }
                    },
                    child: const Text('Enviar'),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
