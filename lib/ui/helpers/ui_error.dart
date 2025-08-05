enum UiError {
  unexpected,
  invalidEmail,
  emailInUse,
  weakPassword,
  invalidCredential,
  emailNotVerified,
}

extension UiErrorExtension on UiError {
  String get message {
    switch (this) {
      case UiError.unexpected:
        return 'Ocorreu um erro inesperado. Por favor, tente novamente mais tarde.';
      case UiError.invalidEmail:
        return 'O e-mail informado é inválido. Por favor, verifique e tente novamente.';
      case UiError.emailInUse:
        return 'Este e-mail já está em uso. Por favor, tente com outro e-mail.';
      case UiError.weakPassword:
        return 'A senha informada é muito fraca. Por favor, escolha uma senha mais forte.';
      case UiError.invalidCredential:
        return 'As credenciais informadas são inválidas. Por favor, verifique e tente novamente.';
      case UiError.emailNotVerified:
        return 'Seu e-mail ainda não foi verificado. Por favor, verifique sua caixa de entrada e siga as instruções para ativar sua conta.';
    }
  }
}
