import 'package:flutter/widgets.dart';

import '../../l10n/generated/app_localizations.dart';
import 'ui_error.dart';

/// Traduz um [UiError] para a frase exibida ao usuário.
///
/// Fica separada do enum porque a tradução precisa do `BuildContext`, que a
/// camada de presentation não conhece: lá o erro trafega como valor.
extension UiErrorTranslation on UiError {
  String message(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    switch (this) {
      case UiError.unexpected:
        return l10n.errorUnexpected;
      case UiError.invalidEmail:
        return l10n.errorInvalidEmail;
      case UiError.emailInUse:
        return l10n.errorEmailInUse;
      case UiError.weakPassword:
        return l10n.errorWeakPassword;
      case UiError.invalidCredential:
        return l10n.errorInvalidCredential;
      case UiError.emailNotVerified:
        return l10n.errorEmailNotVerified;
      case UiError.invalidDueDate:
        return l10n.errorInvalidDueDate;
      case UiError.cancelled:
        return l10n.errorCancelled;
    }
  }
}
