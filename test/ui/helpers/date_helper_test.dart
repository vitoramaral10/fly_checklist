import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/ui/helpers/helpers.dart';

void main() {
  setUpAll(() async {
    await initializeAppDateFormatting();
  });

  // O locale ativo é global: cada teste devolve o padrão para não vazar o
  // idioma que escolheu para os seguintes.
  tearDown(() => setAppDateLocale(const Locale('pt')));

  group('appDateLocale', () {
    test('Should default to pt_BR', () {
      expect(appDateLocale, defaultDateLocale);
      expect(appDateLocale, 'pt_BR');
    });

    test('Should follow the locale resolved by the UI', () {
      setAppDateLocale(const Locale('en'));
      expect(appDateLocale, 'en_US');

      setAppDateLocale(const Locale('es'));
      expect(appDateLocale, 'es_ES');

      setAppDateLocale(const Locale('pt'));
      expect(appDateLocale, 'pt_BR');
    });

    test('Should fall back to the default locale on an unsupported language', () {
      setAppDateLocale(const Locale('de'));

      expect(appDateLocale, defaultDateLocale);
    });

    test('Should ignore the country code of the resolved locale', () {
      setAppDateLocale(const Locale('en', 'GB'));

      expect(appDateLocale, 'en_US');
    });
  });

  group('appDateFormat', () {
    test(
      'Should format and parse a date back to the same day in every supported locale',
      () {
        final date = DateTime(2026, 3, 15);

        for (final locale in const [Locale('pt'), Locale('en'), Locale('es')]) {
          setAppDateLocale(locale);

          final formatted = appDateFormat.format(date);
          final parsed = appDateFormat.parseStrict(formatted);

          expect(
            dateOnly(parsed),
            dateOnly(date),
            reason: 'round-trip falhou em ${locale.languageCode}',
          );
        }
      },
    );

    test('Should use the day-first short format in pt', () {
      setAppDateLocale(const Locale('pt'));

      expect(appDateFormat.format(DateTime(2026, 3, 15)), '15/03/2026');
    });

    test('Should use the month-first short format in en', () {
      setAppDateLocale(const Locale('en'));

      expect(appDateFormat.format(DateTime(2026, 3, 15)), '3/15/2026');
    });

    test(
      'Should read back a date written in another locale as a different day',
      () {
        // Documenta por que formatação e leitura precisam do mesmo locale: em
        // 3/1 o dia e o mês são ambos válidos, e trocar o idioma no meio do
        // caminho inverte a data sem erro nenhum.
        setAppDateLocale(const Locale('en'));
        final writtenInEnglish = appDateFormat.format(DateTime(2026, 3, 1));

        setAppDateLocale(const Locale('pt'));
        final readInPortuguese = appDateFormat.parseStrict(writtenInEnglish);

        expect(readInPortuguese, DateTime(2026, 1, 3));
      },
    );
  });

  group('isDateInPast', () {
    test('Should return false if date is today', () {
      final result = isDateInPast(DateTime.now());

      expect(result, isFalse);
    });

    test('Should return true if date is yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));

      final result = isDateInPast(yesterday);

      expect(result, isTrue);
    });

    test('Should return false if date is tomorrow', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));

      final result = isDateInPast(tomorrow);

      expect(result, isFalse);
    });
  });
}
