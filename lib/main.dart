import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main/routes.dart';

void main() {
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
        // 2. Usa o esquema de cores gerado, mas sobrescreve a cor primária
        //    com o tom de vermelho exato que você quer.
        colorScheme: colorScheme.copyWith(primary: Color(0xFFE10600)),
        useMaterial3: true, // Garante que o Material 3 está ativo
        brightness: Brightness.light, // Define o brilho como claro
      ),
      initialRoute: Routes.home,
      getPages: Routes.pages,
    );
  }
}
