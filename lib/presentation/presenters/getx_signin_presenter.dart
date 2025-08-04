import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/signin/signin.dart';

class GetxSignInPresenter extends GetxController implements SignInPresenter {
  final LoginWithEmail loginWithEmail;
  final LoginWithGoogle loginWithGoogle;
  final RecoveryPassword recoveryPassword;

  GetxSignInPresenter({
    required this.loginWithEmail,
    required this.loginWithGoogle,
    required this.recoveryPassword,
  });

  final formKey = GlobalKey<FormState>();
  final formRecoverKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailRecoveryController = TextEditingController();

  final _obscurePassword = true.obs;
  final _isLoading = false.obs;

  @override
  bool get obscurePassword => _obscurePassword.value;
  @override
  bool get isLoading => _isLoading.value;

  @override
  void togglePasswordVisibility() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  @override
  Future<void> signIn() async {
    if (formKey.currentState?.validate() ?? false) {
      _isLoading.value = true;
      try {
        await loginWithEmail.call(
          email: emailController.text,
          password: passwordController.text,
        );
      } on DomainError catch (e) {
        log(e.toString(), name: 'GetxSignInPresenter.signIn');

        switch (e) {
          case DomainError.invalidCredential:
            throw UiError.invalidCredential;
          default:
            throw UiError.unexpected;
        }
      } catch (e) {
        log(e.toString(), name: 'GetxSignInPresenter.signIn');

        throw UiError.unexpected;
      } finally {
        _isLoading.value = false;
      }
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      await loginWithGoogle.call();
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxSignInPresenter.signInWithGoogle');

      throw UiError.unexpected;
    }
  }

  @override
  Future<void> recoverPassword() async {
    if (formRecoverKey.currentState?.validate() ?? false) {
      _isLoading.value = true;
      try {
        // Assuming a method exists in the use case to handle password recovery
        return recoveryPassword.call(email: emailRecoveryController.text);
      } on DomainError catch (e) {
        log(e.toString(), name: 'GetxSignInPresenter.recoverPassword');

        switch (e) {
          case DomainError.invalidEmail:
            throw UiError.invalidEmail;
          default:
            throw UiError.unexpected;
        }
      } catch (e) {
        log(e.toString(), name: 'GetxSignInPresenter.recoverPassword');
        throw UiError.unexpected;
      } finally {
        _isLoading.value = false;
      }
    }
  }
}
