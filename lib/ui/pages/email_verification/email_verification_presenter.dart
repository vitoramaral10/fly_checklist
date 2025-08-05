abstract class EmailVerificationPresenter {
  Future<void> logout();
  void verifyEmail();
  Future<void> sendEmailVerification();
}
