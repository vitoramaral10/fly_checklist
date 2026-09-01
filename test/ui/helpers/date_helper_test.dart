import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/ui/helpers/helpers.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting(appDateLocale);
  });

  group('appDateFormat', () {
    test(
      'Should format and parse a date back to the same day in pt_BR',
      () {
        final date = DateTime(2026, 3, 15);

        final formatted = appDateFormat.format(date);
        final parsed = appDateFormat.parseStrict(formatted);

        expect(dateOnly(parsed), dateOnly(date));
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
