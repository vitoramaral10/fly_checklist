import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/signin/signin.dart';

class GetxSignInPresenter extends GetxController implements SignInPresenter {
  final LoginWithGoogle loginWithGoogle;

  GetxSignInPresenter({required this.loginWithGoogle});

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
        // Simulate a sign-in process
        await Future.delayed(const Duration(seconds: 2));
        // Handle successful sign-in logic here
      } catch (e) {
        // Handle sign-in error logic here
        Get.snackbar('Error', 'Failed to sign in: $e');
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
