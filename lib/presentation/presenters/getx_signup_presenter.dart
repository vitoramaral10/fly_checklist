import 'package:get/get.dart';

import '../../ui/pages/signup/signup.dart';

class GetxSignUpPresenter implements SignUpPresenter {
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
}
