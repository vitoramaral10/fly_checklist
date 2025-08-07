import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';

class GroupPage extends GetView<GetxGroupPresenter> {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError != null) {
          return Center(
            child: Text(
              'Erro ao carregar o grupo: ${controller.hasError}',
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.error),
            ),
          );
        }

        final group = controller.group;

        if (group == null) {
          return const Center(child: Text('Grupo não encontrado.'));
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar.large(
              pinned: true,
              title: Text(group.name),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded),
                  onPressed: () {
                    // TODO: Implementar menu de opções
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  group.name,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                titlePadding: const EdgeInsetsDirectional.only(
                  start: 16,
                  bottom: 16,
                ),
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                background: Container(
                  color: group.color.withAlpha(50),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        bottom: -50,
                        right: -50,
                        child: Icon(
                          group.icon,
                          size: 250,
                          color: group.color.withAlpha(30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (group.description != null &&
                        group.description!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descrição',
                            style: textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            group.description!,
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    Text(
                      'Tarefas',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final task = controller.tasks[index];
                  return TaskItem(
                    task: task,
                    onCheckboxChanged: (value) {
                      // TODO: Implement task update
                    },
                  );
                }, childCount: controller.tasks.length),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement create task
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
