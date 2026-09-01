import 'package:flutter/material.dart';
import 'package:fly_checklist/ui/components/components.dart';
import 'package:get/get.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../../main/routes.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/ui_error_translation.dart';

void showChangePasswordBottomSheet(BuildContext context) {
  if (!context.mounted) return;
  Get.find<GetxSettingsPresenter>().clearChangePasswordFields();
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
    final l10n = AppLocalizations.of(context);
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
                    child: Text(
                      l10n.settingsChangePassword,
                      style: textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: controller.currentPasswordController,
                    obscureText: !controller.showCurrentPassword,
                    decoration: InputDecoration(
                      labelText: l10n.fieldCurrentPasswordLabel,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showCurrentPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        tooltip: controller.showCurrentPassword
                            ? l10n.passwordHideTooltip
                            : l10n.passwordShowTooltip,
                        onPressed: () {
                          controller.toggleShowCurrentPassword();
                        },
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.validatorCurrentPasswordRequired;
                      }
                      if (value.length < 6) {
                        return l10n.validatorPasswordMinLength;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.newPasswordController,
                    obscureText: !controller.showNewPassword,
                    decoration: InputDecoration(
                      labelText: l10n.fieldNewPasswordLabel,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        tooltip: controller.showNewPassword
                            ? l10n.passwordHideTooltip
                            : l10n.passwordShowTooltip,
                        onPressed: () {
                          controller.toggleShowNewPassword();
                        },
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.validatorNewPasswordRequired;
                      }
                      if (value.length < 6) {
                        return l10n.validatorNewPasswordMinLength;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.confirmNewPasswordController,
                    obscureText: !controller.showConfirmNewPassword,
                    decoration: InputDecoration(
                      labelText: l10n.fieldConfirmNewPasswordLabel,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showConfirmNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        tooltip: controller.showConfirmNewPassword
                            ? l10n.passwordHideTooltip
                            : l10n.passwordShowTooltip,
                        onPressed: () {
                          controller.toggleShowConfirmNewPassword();
                        },
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.validatorConfirmNewPasswordRequired;
                      }
                      if (value != controller.newPasswordController.text) {
                        return l10n.validatorPasswordsDoNotMatch;
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
                          final changed = await controller
                              .changePasswordAction();
                          if (!context.mounted) return;
                          // Fecha o diálogo de loading
                          Navigator.of(context).pop();

                          // Formulário inválido: mantém o bottom sheet aberto
                          // com o que já foi digitado.
                          if (!changed) return;

                          Navigator.of(context).pop(); // Fecha o bottom sheet
                          showSuccessSnackbar(
                            context,
                            message: l10n.changePasswordSuccess,
                          );
                          Get.offAllNamed(Routes.home);
                        } on UiError catch (e) {
                          // Fecha o loading antes de exibir o erro, senão o
                          // diálogo (barrierDismissible: false) fica preso.
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) {
                            showErrorDialog(context, e.message(context));
                          }
                        }
                      },
                      child: Text(l10n.changePasswordSubmit),
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
