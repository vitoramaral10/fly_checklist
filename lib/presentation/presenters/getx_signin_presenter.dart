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

  GetxSignInPresenter({
    required this.loginWithEmail,
    required this.loginWithGoogle,
  });

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
}
