import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';

class HomePage extends GetView<GetxHomePresenter> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fundo com gradiente sutil para um visual moderno.
          // As cores são baseadas no tema do app (Material 3), garantindo consistência.
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorScheme.primaryContainer.withValues(alpha: 0.3),
                  colorScheme.surface,
                  colorScheme.surface,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          // Conteúdo da página
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Ícone principal que remete à identidade do app.
                    Icon(
                      Icons.task_alt_rounded,
                      size: 120,
                      color: colorScheme.primary,
                      shadows: [
                        Shadow(
                          color: colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Título do aplicativo.
                    Text(
                      'Fly Checklist',
                      style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Subtítulo ou slogan.
                    Text(
                      'Organize suas tarefas e alcance seus objetivos com simplicidade.',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(flex: 2),

                    const SizedBox(height: 12),
                    if (!controller.enableButtons)
                      const CircularProgressIndicator(),
                    if (controller.enableButtons)
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            Get.offAllNamed(Routes.signIn);
                          },
                          icon: const Icon(Icons.login_rounded),
                          label: const Text('Acessar minha conta'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    // Botão de ação secundária.
                    if (controller.enableButtons)
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.signUp);
                          },
                          child: const Text('Criar conta'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
