import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui/pages/signup/signup.dart';

class GetxSignUpPresenter implements SignUpPresenter {
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
    if (formKey.currentState!.validate() == true) {}
  }

  @override
  Future<void> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }
}
