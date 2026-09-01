abstract class SignUpPresenter {
  bool get obscurePassword;
  bool get obscureConfirmPassword;
  bool get isLoading;

  void togglePasswordVisibility();
  void toggleConfirmPasswordVisibility();
  Future<void> signUp();
  Future<void> signUpWithGoogle();
}
