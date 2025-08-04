enum UiError { unexpected, invalidEmail, emailInUse, weakPassword }

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
    }
  }
}
