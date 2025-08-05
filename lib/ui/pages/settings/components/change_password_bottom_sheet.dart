import 'package:flutter/material.dart';
import 'package:fly_checklist/ui/components/components.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../helpers/helpers.dart';

void showChangePasswordBottomSheet(BuildContext context) {
  if (!context.mounted) return;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (context) => const _ChangePasswordBottomSheetContent(),
  );
}

class _ChangePasswordBottomSheetContent extends GetView<GetxSettingsPresenter> {
  const _ChangePasswordBottomSheetContent();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Form(
            key: controller.formChangePasswordKey,
            child: Obx(
              () => Column(
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
                    child: Text('Alterar Senha', style: textTheme.titleLarge),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: controller.currentPasswordController,
                    obscureText: !controller.showCurrentPassword,
                    decoration: InputDecoration(
                      labelText: 'Senha Atual',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showCurrentPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          controller.toggleShowCurrentPassword();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha atual.';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.newPasswordController,
                    obscureText: !controller.showNewPassword,
                    decoration: InputDecoration(
                      labelText: 'Nova Senha',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          controller.toggleShowNewPassword();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a nova senha.';
                      }
                      if (value.length < 6) {
                        return 'A nova senha deve ter pelo menos 6 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.confirmNewPasswordController,
                    obscureText: !controller.showConfirmNewPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Nova Senha',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showConfirmNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          controller.toggleShowConfirmNewPassword();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, confirme a nova senha.';
                      }
                      if (value != controller.newPasswordController.text) {
                        return 'As senhas não coincidem.';
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
                          await controller.changePasswordAction();
                          if (!context.mounted) return;
                          Navigator.of(
                            context,
                          ).pop(); // Fecha o diálogo de loading
                          Navigator.of(context).pop(); // Fecha o bottom sheet
                          showSuccessDialog(
                            context,
                            'Senha alterada com sucesso!',
                          );
                        } on UiError catch (e) {
                          showErrorDialog(context, e.message);
                        }
                      },
                      child: const Text('Salvar Alterações'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
