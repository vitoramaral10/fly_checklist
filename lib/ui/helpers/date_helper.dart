import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// Locale de datas usado enquanto o `MaterialApp` ainda não resolveu o idioma
/// — e também quando o idioma resolvido não é um dos suportados.
const String defaultDateLocale = 'pt_BR';

/// Locale `intl` de cada idioma suportado pelo app.
///
/// O `MaterialApp` resolve para os locales gerados pelo gen-l10n (`pt`, `en`,
/// `es`, sem país), então a chave é sempre o código de idioma.
const Map<String, String> dateLocaleByLanguage = {
  'pt': 'pt_BR',
  'en': 'en_US',
  'es': 'es_ES',
};

/// Todos os locales de datas que precisam ter os símbolos carregados no boot.
const List<String> supportedDateLocales = ['pt_BR', 'en_US', 'es_ES'];

String _activeDateLocale = defaultDateLocale;

/// Locale que [appDateFormat] usa neste momento.
///
/// Formatação e interpretação passam pelo mesmo valor de propósito: o formato
/// curto muda de d/M/y para M/d/y conforme o idioma, e ler uma data com um
/// locale diferente do que a escreveu inverte dia e mês em silêncio.
String get appDateLocale => _activeDateLocale;

/// Locale `intl` equivalente ao [locale] resolvido pelo Flutter.
String dateLocaleOf(Locale locale) =>
    dateLocaleByLanguage[locale.languageCode] ?? defaultDateLocale;

/// Passa a formatar e interpretar datas no idioma que a UI está exibindo.
///
/// Chamada do `builder` do `GetMaterialApp`, abaixo do `Localizations`, onde o
/// locale já foi resolvido contra os idiomas suportados.
void setAppDateLocale(Locale locale) {
  _activeDateLocale = dateLocaleOf(locale);
}

/// Carrega os símbolos de data dos idiomas suportados.
///
/// Precisa rodar antes do `runApp`: sem isso `DateFormat` lança
/// `LocaleDataException` ao trocar de idioma.
Future<void> initializeAppDateFormatting() async {
  for (final locale in supportedDateLocales) {
    await initializeDateFormatting(locale);
  }
}

/// Formato curto de data no locale ativo, usado nos campos e na exibição.
DateFormat get appDateFormat => DateFormat.yMd(appDateLocale);

DateTime dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

/// Compara apenas o dia: a data de hoje não é considerada passado.
bool isDateInPast(DateTime date) =>
    dateOnly(date).isBefore(dateOnly(DateTime.now()));
