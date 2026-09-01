import 'package:flutter/widgets.dart';

/// Idioma usado quando nenhum dos idiomas do aparelho é suportado.
///
/// A resolução padrão do Flutter cairia no primeiro item de `supportedLocales`
/// — que o gen-l10n ordena alfabeticamente, e portanto seria inglês.
const Locale appFallbackLocale = Locale('pt');

/// Escolhe o idioma do app a partir da lista de preferências do aparelho.
///
/// Compara só o código de idioma: os locales suportados são gerados sem país
/// (`pt`, `en`, `es`), então um aparelho em `pt_PT` ou `en_GB` também casa.
Locale resolveAppLocale(
  List<Locale>? deviceLocales,
  Iterable<Locale> supportedLocales,
) {
  for (final deviceLocale in deviceLocales ?? const <Locale>[]) {
    for (final supported in supportedLocales) {
      if (supported.languageCode == deviceLocale.languageCode) {
        return supported;
      }
    }
  }
  return appFallbackLocale;
}
