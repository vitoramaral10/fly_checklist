import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../main/routes.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxSignUpPresenter implements SignUpPresenter {
  final RegisterWithGoogle registerWithGoogle;

  GetxSignUpPresenter({required this.registerWithGoogle});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _obscurePassword = true.obs;
  final _obscureConfirmPassword = true.obs;

  @override
  bool get obscurePassword => _obscurePassword.value;
  @override
  bool get obscureConfirmPassword => _obscureConfirmPassword.value;

  @override
  void togglePasswordVisibility() => _obscurePassword.toggle();

  @override
  void toggleConfirmPasswordVisibility() => _obscureConfirmPassword.toggle();

  @override
  Future<void> signUp() async {
    if (formKey.currentState!.validate() == true) {
      // TODO: implement signUp
      throw UnimplementedError();
    }
  }

  @override
  Future<void> signUpWithGoogle() async {
    try {
      await registerWithGoogle.call();
    } on DomainError catch (e) {
      log(e.toString(), name: 'GetxSignUpPresenter.signUpWithGoogle');

      throw UiError.unexpected;
    }
  }
}
