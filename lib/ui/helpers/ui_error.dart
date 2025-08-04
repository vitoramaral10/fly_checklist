enum UiError { unexpected }

extension UiErrorExtension on UiError {
  String get message {
    switch (this) {
      case UiError.unexpected:
        return 'Ocorreu um erro inesperado. Por favor, tente novamente mais tarde.';
    }
  }
}
