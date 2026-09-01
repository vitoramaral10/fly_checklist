import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxSignUpPresenter extends GetxController implements SignUpPresenter {
  final RegisterWithEmail registerWithEmail;
  final RegisterWithGoogle registerWithGoogle;
  final SendVerificationEmail sendVerificationEmail;

  GetxSignUpPresenter({
    required this.registerWithEmail,
    required this.registerWithGoogle,
    required this.sendVerificationEmail,
  });

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _obscurePassword = true.obs;
  final _obscureConfirmPassword = true.obs;
  final _isLoading = false.obs;

  @override
  bool get obscurePassword => _obscurePassword.value;
  @override
  bool get obscureConfirmPassword => _obscureConfirmPassword.value;
  @override
  bool get isLoading => _isLoading.value;

  @override
  void togglePasswordVisibility() => _obscurePassword.toggle();

  @override
  void toggleConfirmPasswordVisibility() => _obscureConfirmPassword.toggle();

  @override
  Future<void> signUp() async {
    if (formKey.currentState!.validate() == true) {
      _isLoading.value = true;
      try {
        await registerWithEmail.call(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        await sendVerificationEmail.call();
      } on DomainError catch (e) {
        log(e.toString(), name: 'GetxSignUpPresenter.signUp');

        switch (e) {
          case DomainError.invalidEmail:
            throw UiError.invalidEmail;
          case DomainError.emailInUse:
            throw UiError.emailInUse;
          case DomainError.weakPassword:
            throw UiError.weakPassword;
          default:
            throw UiError.unexpected;
        }
      } catch (e) {
        log(e.toString(), name: 'GetxSignUpPresenter.signUp.unexpected');

        throw UiError.unexpected;
      } finally {
        _isLoading.value = false;
      }
    }
  }

  @override
  Future<void> signUpWithGoogle() async {
    _isLoading.value = true;
    try {
      await registerWithGoogle.call();
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxSignUpPresenter.signUpWithGoogle');

      switch (e) {
        case DomainError.cancelled:
          throw UiError.cancelled;
        default:
          throw UiError.unexpected;
      }
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
