/// Erros que a UI sabe explicar ao usuário.
///
/// É só o enum: a frase de cada caso mora em [UiErrorTranslation], na camada
/// de UI, porque depende do `BuildContext` para saber o idioma. Presenters
/// lançam o valor; quem tem contexto traduz.
enum UiError {
  unexpected,
  invalidEmail,
  emailInUse,
  weakPassword,
  invalidCredential,
  emailNotVerified,
  invalidDueDate,
  cancelled,
}
