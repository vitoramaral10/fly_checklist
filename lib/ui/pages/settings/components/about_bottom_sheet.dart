import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void showAboutBottomSheet(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  if (!context.mounted) return;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (context) => _AboutBottomSheetContent(packageInfo: packageInfo),
  );
}

class _AboutBottomSheetContent extends StatelessWidget {
  const _AboutBottomSheetContent({required this.packageInfo});

  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final features = [
      {
        'title': 'Checklists Reutilizáveis:',
        'description':
            'O recurso principal. Crie uma lista para sua rotina (ex: preparar o café da manhã, rotina de exercícios) e ela estará sempre pronta e desmarcada para a próxima vez, economizando seu tempo e esforço.',
      },
      {
        'title': 'Metodologia da Aviação:',
        'description':
            'Traz um conceito de disciplina e precisão para garantir que nenhuma etapa de um processo importante seja pulada.',
      },
      {
        'title': 'Agrupamento Inteligente:',
        'description':
            'Organize múltiplos checklists em grupos temáticos (ex: "Manhã", "Fim do Dia", "Projeto X"), mantendo sua vida pessoal e profissional perfeitamente ordenada.',
      },
      {
        'title': 'Flexibilidade Total:',
        'description':
            'Ideal tanto para uma simples lista de tarefas quanto para processos complexos que exigem uma sequência de ações verificadas.',
      },
    ];

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withAlpha(100),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text('Sobre o App', style: textTheme.headlineSmall),
              ),
              const SizedBox(height: 16),
              const Text(
                'O Fly Checklist é uma solução inovadora para gerenciamento de tarefas, que aplica a metodologia dos checklists de aviação para otimizar seu dia a dia.\n\n'
                'O segredo está na capacidade de criar grupos de checklists "não persistentes". Enquanto um To-Do list tradicional salva suas marcações, o Fly Checklist permite que certas listas voltem ao estado original após o uso, tornando-o perfeito para tarefas recorrentes.',
              ),
              const SizedBox(height: 24),
              Text('Principais Funcionalidades:', style: textTheme.titleLarge),
              const SizedBox(height: 12),
              ...features.map(
                (feature) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: feature['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${feature['description']}'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'Fly Checklist é a ferramenta definitiva para quem busca transformar rotinas em hábitos sólidos e eficientes.',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Versão ${packageInfo.version}',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Desenvolvido por Vitor Melo',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '© ${DateTime.now().year} Fly Checklist. Todos os direitos reservados.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
