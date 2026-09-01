import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../helpers/ui_error_translation.dart';
import '../dashboard/components/components.dart';

class GroupPage extends GetView<GetxGroupPresenter> {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading) {
          return const _GroupLoadingPage();
        }

        final error = controller.hasError;
        if (error != null) {
          return Center(
            child: Text(
              l10n.groupLoadError(error.message(context)),
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.error),
            ),
          );
        }

        final group = controller.group;

        if (group == null) {
          return Center(child: Text(l10n.groupNotFound));
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
                    tooltip: l10n.groupMenuTooltip,
                    onSelected: (value) {
                      switch (value) {
                        case 'reset':
                          _resetChecklist(context, group);
                          break;
                        case 'edit':
                          _editGroup(context, group);
                          break;
                        case 'delete':
                          _deleteGroup(context, group);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      // Reiniciar só faz sentido em grupo que não salva o
                      // estado dos checks; nos demais o usuário pediu
                      // explicitamente para os checks durarem.
                      if (group.isReusableChecklist) ...[
                        PopupMenuItem(
                          value: 'reset',
                          child: ListTile(
                            leading: const Icon(Icons.restart_alt_rounded),
                            title: Text(l10n.groupResetChecklist),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuDivider(),
                      ],
                      PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: const Icon(Icons.edit_rounded),
                          title: Text(l10n.groupEdit),
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
                            l10n.groupDelete,
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
                      if (group.isReusableChecklist) ...[
                        _ReusableChecklistBadge(color: group.color),
                        const SizedBox(height: 16),
                      ],
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
                              l10n.groupDescriptionLabel,
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
                            l10n.groupTasksTitle,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AddTaskButton(
                            label: l10n.groupNewTask,
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
                            l10n.groupNoTasksTitle,
                            style: textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.groupNoTasksMessage,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          AddTaskButton(
                            tonal: false,
                            onPressed: () => _createTask(context, group),
                            label: l10n.addTaskButtonLabel,
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
                              l10n.taskUpdateErrorTitle,
                              l10n.taskUpdateErrorMessage,
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
    final l10n = AppLocalizations.of(context);

    final isDelete = await showConfirmationDialog(
      context,
      title: l10n.taskDeleteConfirmTitle,
      content: l10n.taskDeleteConfirmContent,
      destructive: true,
    );

    if (!isDelete || !context.mounted) return false;

    showLoadingDialog(context);

    try {
      await controller.onDeleteTask(task);
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        showSuccessSnackbar(
          context,
          title: l10n.taskDeletedSnackbarTitle,
          message: l10n.taskDeletedSnackbarMessage(task.title),
        );
      }
      return true;
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      showErrorSnackbar(l10n.taskDeleteErrorTitle, l10n.taskDeleteErrorMessage);
      return false;
    }
  }

  Future<void> _resetChecklist(BuildContext context, GroupEntity group) async {
    final l10n = AppLocalizations.of(context);

    final isReset = await showConfirmationDialog(
      context,
      title: l10n.groupResetChecklist,
      content: l10n.groupResetConfirmContent(group.name),
      confirmLabel: l10n.groupResetConfirmAction,
    );

    if (!isReset || !context.mounted) return;

    try {
      showLoadingDialog(context);
      await controller.onResetGroupTasks();
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        showSuccessSnackbar(
          context,
          title: l10n.groupResetSuccessTitle,
          message: l10n.groupResetSuccessMessage(group.name),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      showErrorSnackbar(
        l10n.groupResetErrorTitle,
        l10n.groupResetErrorMessage,
      );
    }
  }

  Future<void> _deleteGroup(BuildContext context, GroupEntity group) async {
    final l10n = AppLocalizations.of(context);

    final isDelete = await showConfirmationDialog(
      context,
      title: l10n.groupDelete,
      content: l10n.groupDeleteConfirmContent,
      confirmLabel: l10n.commonDelete,
      destructive: true,
    );

    if (!isDelete || !context.mounted) return;

    try {
      showLoadingDialog(context);
      await controller.onDeleteGroup(group);
      if (context.mounted) Navigator.of(context).pop();
      Get.back();
      if (context.mounted) {
        showSuccessSnackbar(context, message: l10n.groupDeletedSuccess);
      }
    } on UiError catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) showErrorDialog(context, e.message(context));
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        showErrorDialog(context, UiError.unexpected.message(context));
      }
    }
  }
}

/// Deixa explícito que o grupo é um checklist reutilizável: os checks não
/// duram de um dia para o outro.
class _ReusableChecklistBadge extends StatelessWidget {
  final Color color;

  const _ReusableChecklistBadge({required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.restart_alt_rounded, size: 18, color: color),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              AppLocalizations.of(context).groupReusableChecklistBadge,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
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
