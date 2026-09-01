import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'domain/entities/entities.dart';
import 'firebase_options.dart';
import 'l10n/generated/app_localizations.dart';
import 'main/factories/factories.dart';
import 'main/routes.dart';
import 'ui/helpers/helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeAppDateFormatting();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Prepara o canal de notificações antes da primeira tela. Falhar aqui só
  // custa os lembretes: o adapter tenta de novo no primeiro agendamento.
  await makeLocalNotificationsAdapter().initialize();

  final initialThemeMode = await makeLocalGetThemeMode().call();

  runApp(MyApp(initialThemeMode: initialThemeMode));
}

class MyApp extends StatelessWidget {
  final AppThemeMode initialThemeMode;

  const MyApp({super.key, required this.initialThemeMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 1. Gera o esquema de cores a partir da semente.
    final seed = const Color(0xFFE10600);
    final lightScheme = ColorScheme.fromSeed(seedColor: seed);
    final darkScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );

    return GetMaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      themeMode: _toFlutterThemeMode(initialThemeMode),
      theme: _buildTheme(lightScheme),
      darkTheme: _buildTheme(darkScheme),
      initialRoute: Routes.home,
      getPages: Routes.pages,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // `locale` fica nulo de propósito: sem ele o app segue o idioma do
      // aparelho, e o callback abaixo garante o português quando nenhum dos
      // idiomas preferidos do usuário é suportado.
      fallbackLocale: appFallbackLocale,
      localeListResolutionCallback: resolveAppLocale,
      // Roda abaixo do `Localizations`, então aqui o idioma já está resolvido:
      // é o ponto certo para alinhar o locale de datas ao da interface.
      builder: (context, child) {
        setAppDateLocale(Localizations.localeOf(context));
        return child ?? const SizedBox.shrink();
      },
    );
  }
}

ThemeMode _toFlutterThemeMode(AppThemeMode themeMode) {
  switch (themeMode) {
    case AppThemeMode.light:
      return ThemeMode.light;
    case AppThemeMode.dark:
      return ThemeMode.dark;
    case AppThemeMode.system:
      return ThemeMode.system;
  }
}

ThemeData _buildTheme(ColorScheme scheme) {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    brightness: scheme.brightness,
  );

  return base.copyWith(
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
      ),
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      iconColor: scheme.onSurfaceVariant,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.25),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        side: BorderSide(color: scheme.outlineVariant),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: scheme.outlineVariant, width: 1.5),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: scheme.inverseSurface,
      contentTextStyle: TextStyle(color: scheme.onInverseSurface),
      actionTextColor: scheme.inversePrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: scheme.surface,
      surfaceTintColor: scheme.surfaceTint,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: scheme.surface,
      surfaceTintColor: scheme.surfaceTint,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: TextStyle(
        color: scheme.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerTheme: DividerThemeData(color: scheme.outlineVariant),
  );
}
