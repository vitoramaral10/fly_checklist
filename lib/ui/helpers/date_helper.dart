import 'package:intl/intl.dart';

/// Locale único usado para formatar e interpretar datas em todo o app.
///
/// Precisa ser inicializado com `initializeDateFormatting(appDateLocale)`
/// antes do `runApp`, caso contrário `DateFormat` lança `LocaleDataException`.
const String appDateLocale = 'pt_BR';

/// Formato curto de data (dd/MM/yyyy) usado nos campos e na exibição.
DateFormat get appDateFormat => DateFormat.yMd(appDateLocale);

DateTime dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

/// Compara apenas o dia: a data de hoje não é considerada passado.
bool isDateInPast(DateTime date) =>
    dateOnly(date).isBefore(dateOnly(DateTime.now()));
