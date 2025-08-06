import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'main/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 1. Gera o esquema de cores a partir da semente.
    final colorScheme = ColorScheme.fromSeed(seedColor: Color(0xFFE10600));

    return GetMaterialApp(
      title: 'Fly Checklist',
      theme: ThemeData(
        colorScheme: colorScheme.copyWith(primary: Color(0xFFE10600)),
        useMaterial3: true, // Garante que o Material 3 está ativo
        brightness: Brightness.light, // Define o brilho como claro
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1.5),
        ),
      ),
      initialRoute: Routes.home,
      getPages: Routes.pages,
    );
  }
}
