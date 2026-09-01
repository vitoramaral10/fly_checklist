import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../helpers/ui_error_translation.dart';

class SignUpPage extends GetView<GetxSignUpPresenter> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signUpAppBarTitle), centerTitle: true),
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
                  l10n.signUpWelcomeTitle,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.signUpWelcomeSubtitle,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: l10n.fieldFullNameLabel,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.validatorFullNameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: l10n.fieldEmailLabel,
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.validatorEmailRequired;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return l10n.validatorEmailInvalidShort;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      labelText: l10n.fieldPasswordLabel,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    obscureText: controller.obscurePassword,
                    textInputAction: TextInputAction.next,
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
                const SizedBox(height: 20),
                Obx(
                  () => TextFormField(
                    controller: controller.confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: l10n.fieldConfirmPasswordLabel,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureConfirmPassword
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    obscureText: controller.obscureConfirmPassword,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.validatorConfirmPasswordRequired;
                      }
                      if (value != controller.passwordController.text) {
                        return l10n.validatorPasswordsDoNotMatch;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Obx(
                  () => FilledButton(
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                            try {
                              showLoadingDialog(context);
                              await controller.signUp();
                              if (context.mounted) Navigator.of(context).pop();
                              Get.offAllNamed(Routes.emailVerification);
                            } on UiError catch (e) {
                              if (context.mounted) Navigator.of(context).pop();
                              if (context.mounted) {
                                showErrorDialog(context, e.message(context));
                              }
                            }
                          },
                    child: Text(
                      controller.isLoading
                          ? l10n.signUpSubmitLoading
                          : l10n.signUpSubmit,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.signIn);
                  },
                  child: Text(
                    l10n.signUpGoToSignIn,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                // Google Sign-In Button
                const SizedBox(height: 16),
                Text(
                  l10n.signUpOrContinueWith,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => GoogleButton(
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                            try {
                              showLoadingDialog(context);
                              await controller.signUpWithGoogle();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
