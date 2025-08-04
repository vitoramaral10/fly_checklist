abstract class SignInPresenter {
  bool get obscurePassword;
  bool get isLoading;

  void togglePasswordVisibility();
  Future<void> signIn();
  Future<void> signInWithGoogle();
  Future<void> recoverPassword();
}
