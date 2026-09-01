import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/l10n/generated/app_localizations.dart';
import 'package:fly_checklist/ui/helpers/helpers.dart';

void main() {
  const supported = AppLocalizations.supportedLocales;

  group('resolveAppLocale', () {
    test('Should return the supported locale that matches the language', () {
      final result = resolveAppLocale(const [Locale('es')], supported);

      expect(result, const Locale('es'));
    });

    test('Should match by language even when the device carries a country', () {
      final result = resolveAppLocale(const [Locale('pt', 'PT')], supported);

      expect(result, const Locale('pt'));
    });

    test('Should honour the order of the device preferences', () {
      final result = resolveAppLocale(const [
        Locale('de'),
        Locale('en', 'GB'),
        Locale('pt', 'BR'),
      ], supported);

      expect(result, const Locale('en'));
    });

    test('Should fall back to Portuguese when no language is supported', () {
      final result = resolveAppLocale(const [Locale('de'), Locale('fr')], supported);

      expect(result, appFallbackLocale);
      expect(result, const Locale('pt'));
    });

    test('Should fall back to Portuguese when the device list is null', () {
      expect(resolveAppLocale(null, supported), appFallbackLocale);
    });

    test('Should fall back to Portuguese when the device list is empty', () {
      expect(resolveAppLocale(const [], supported), appFallbackLocale);
    });
  });
}
