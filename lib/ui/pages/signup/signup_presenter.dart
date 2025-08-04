abstract class SignUpPresenter {
  bool get obscurePassword;
  bool get obscureConfirmPassword;

  void togglePasswordVisibility();
  void toggleConfirmPasswordVisibility();
  Future<void> signUp();
  Future<void> signUpWithGoogle();
}
