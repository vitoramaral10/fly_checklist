import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../dashboard/components/components.dart';

class GroupPage extends GetView<GetxGroupPresenter> {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading) {
          return const _GroupLoadingPage();
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

        return RefreshIndicator(
          onRefresh: () async {
            await controller.loadAllData();
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                pinned: true,
                title: Text(group.name),
                actions: [
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded),
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _editGroup(context, group);
                          break;
                        case 'delete':
                          _deleteGroup(context, group);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit_rounded),
                          title: Text('Editar grupo'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(
                            Icons.delete_outline_rounded,
                            color: colorScheme.error,
                          ),
                          title: Text(
                            'Excluir grupo',
                            style: TextStyle(color: colorScheme.error),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          group.color.withValues(alpha: 0.20),
                          group.color.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          bottom: -50,
                          right: -50,
                          child: Icon(
                            group.icon,
                            size: 250,
                            color: group.color.withValues(alpha: 0.15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (group.description != null &&
                          group.description!.isNotEmpty)
                        Card(
                          elevation: 0,
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: colorScheme.outlineVariant.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.notes_rounded,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            title: Text(
                              'Descrição',
                              style: textTheme.titleSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                group.description!,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (group.description != null &&
                          group.description!.isNotEmpty)
                        const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tarefas',
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AddTaskButton(
                            label: 'Nova tarefa',
                            onPressed: () => _createTask(context, group),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              Obx(() {
                final tasks = controller.tasks;
                if (tasks.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.checklist_rounded,
                            size: 72,
                            color: colorScheme.primary.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Sem tarefas por aqui',
                            style: textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Comece adicionando a primeira tarefa para este grupo.',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AddTaskButton(
                            tonal: false,
                            onPressed: () => _createTask(context, group),
                            label: 'Adicionar tarefa',
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TaskItem(
                        task: task,
                        onTap: () {
                          controller.clearFields();
                          showTaskBottomSheet(
                            context,
                            task: task,
                            presenter: controller,
                          );
                        },
                        confirmDismiss: (direction) =>
                            _deleteTask(context, task),
                        onCheckboxChanged: (value) async {
                          try {
                            await controller.toggleTaskCompletion(task);
                          } catch (e) {
                            showErrorSnackbar(
                              'Erro ao atualizar tarefa',
                              'Não foi possível atualizar o status da tarefa. Tente novamente mais tarde.',
                            );
                          }
                        },
                      ),
                    );
                  }, childCount: tasks.length),
                );
              }),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        );
      }),
    );
  }

  void _createTask(BuildContext context, GroupEntity group) {
    controller.clearFields();
    showTaskBottomSheet(context, presenter: controller, groupId: group.id);
  }

  void _editGroup(BuildContext context, GroupEntity group) {
    controller.clearFields();
    showGroupBottomSheet(
      context,
      group: group,
      presenter: controller,
      onDeleted: () => Get.back(),
    );
  }

  Future<bool> _deleteTask(BuildContext context, TaskEntity task) async {
    final isDelete = await showConfirmationDialog(
      context,
      title: 'Excluir Tarefa',
      content:
          'Tem certeza que deseja excluir esta tarefa? Esta ação não pode ser desfeita.',
      destructive: true,
    );

    if (!isDelete || !context.mounted) return false;

    showLoadingDialog(context);

    try {
      await controller.onDeleteTask(task);
      if (context.mounted) Navigator.of(context).pop();
      showSuccessSnackbar(
        title: 'Tarefa excluída',
        message: 'A tarefa "${task.title}" foi excluída com sucesso.',
      );
      return true;
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      showErrorSnackbar(
        'Erro ao excluir tarefa',
        'Não foi possível excluir a tarefa. Tente novamente mais tarde.',
      );
      return false;
    }
  }

  Future<void> _deleteGroup(BuildContext context, GroupEntity group) async {
    final isDelete = await showConfirmationDialog(
      context,
      title: 'Excluir grupo',
      content:
          'Tem certeza que deseja excluir este grupo? Todas as tarefas associadas também serão removidas. Esta ação não pode ser desfeita.',
      confirmLabel: 'Excluir',
      destructive: true,
    );

    if (!isDelete || !context.mounted) return;

    try {
      showLoadingDialog(context);
      await controller.onDeleteGroup(group);
      if (context.mounted) Navigator.of(context).pop();
      Get.back();
      showSuccessSnackbar(message: 'Grupo excluído com sucesso!');
    } on UiError catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) showErrorDialog(context, e.message);
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        showErrorDialog(context, UiError.unexpected.message);
      }
    }
  }
}

class _GroupLoadingPage extends StatelessWidget {
  const _GroupLoadingPage();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          pinned: true,
          title: ShimmerContainer(width: 160, height: 28, borderRadius: 8),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: colorScheme.surfaceContainerHighest.withAlpha(20),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerContainer(
                  width: double.infinity,
                  height: 80,
                  borderRadius: 16,
                ),
                SizedBox(height: 16),
                ShimmerContainer(width: 140, height: 28),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
        SliverList.builder(
          itemCount: 6,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
            child: ShimmerContainer(
              width: double.infinity,
              height: 64,
              borderRadius: 12,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}
