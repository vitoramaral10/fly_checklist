import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../helpers/ui_error_translation.dart';
import 'components/components.dart';

class SignInPage extends GetView<GetxSignInPresenter> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signInAppBarTitle), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  l10n.signInWelcomeTitle,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.signInWelcomeSubtitle,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: l10n.fieldEmailLabel,
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.validatorEmailRequired;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return l10n.validatorEmailInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.obscurePassword,
                    decoration: InputDecoration(
                      labelText: l10n.fieldPasswordLabel,
                      prefixIcon: const Icon(Icons.lock_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.validatorPasswordRequired;
                      }
                      if (value.length < 6) {
                        return l10n.validatorPasswordMinLength;
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      controller.emailRecoveryController.clear();
                      await showForgotPasswordBottomSheet(context);
                    },
                    child: Text(
                      l10n.signInForgotPassword,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Obx(
                  () => FilledButton(
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                            try {
                              showLoadingDialog(context);
                              final type = await controller.signIn();
                              if (context.mounted) Navigator.of(context).pop();
                              if (type == "email") {
                                Get.offAndToNamed(Routes.emailVerification);
                              } else {
                                Get.offAllNamed(Routes.dashboard);
                              }
                            } on UiError catch (e) {
                              if (context.mounted) Navigator.of(context).pop();
                              if (context.mounted) {
                                showErrorDialog(context, e.message(context));
                              }
                            }
                          },
                    child: Text(
                      controller.isLoading
                          ? l10n.commonLoading
                          : l10n.signInSubmit,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: colorScheme.outline.withAlpha(100),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        l10n.commonOr,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: colorScheme.outline.withAlpha(100),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(
                  () => GoogleButton(
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                            try {
                              showLoadingDialog(context);
                              await controller.signInWithGoogle();
                              if (context.mounted) Navigator.of(context).pop();

                              Get.offAllNamed(Routes.dashboard);
                            } on UiError catch (e) {
                              if (context.mounted) Navigator.of(context).pop();
                              if (e != UiError.cancelled && context.mounted) {
                                showErrorDialog(context, e.message(context));
                              }
                            }
                          },
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Get.offAndToNamed(Routes.signUp),
                  child: Text(
                    l10n.signInGoToSignUp,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
