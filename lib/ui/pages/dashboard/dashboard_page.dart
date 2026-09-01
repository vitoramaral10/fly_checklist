import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../helpers/ui_error_translation.dart';
import '../pages.dart';

class DashboardPage extends GetView<GetxDashboardPresenter> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return const DashboardLoadingPage();
      }

      final user = controller.user;

      if (controller.hasError != null || user == null) {
        return _buildErrorState(context);
      }

      final l10n = AppLocalizations.of(context);
      final theme = Theme.of(context);
      final screenWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        body: SafeArea(
          top: true,
          bottom: false,
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.loadAllData();
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.dashboardGreeting,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              user.name.split(' ')[0],
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.settings);
                          },
                          child: AvatarWithShimmer(
                            imageUrl: user.photoUrl,
                            size: 64,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: _buildQuickTasks(context, theme),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: _buildTaskGroupsHeader(context, theme),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: _buildTaskGroupsGrid(context, theme, screenWidth),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.clearFields();
            showTaskBottomSheet(context);
          },
          child: const Icon(Icons.add_rounded),
        ),
      );
    });
  }

  Widget _buildErrorState(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmptyState(
                icon: Icons.cloud_off_rounded,
                title: l10n.dashboardLoadErrorTitle,
                message: (controller.hasError ?? UiError.unexpected).message(
                  context,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => controller.loadAllData(),
                icon: const Icon(Icons.refresh_rounded),
                label: Text(l10n.commonRetry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickTasks(BuildContext context, ThemeData theme) {
    final l10n = AppLocalizations.of(context);

    // Os dados das tarefas rápidas devem vir do presenter
    return Container(
      constraints: BoxConstraints(
        maxHeight: controller.tasks.isEmpty
            ? 300
            : MediaQuery.of(context).size.height * 0.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionHeader(title: l10n.dashboardQuickTasksTitle),
          const SizedBox(height: 16),
          controller.tasks.isEmpty
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmptyState(
                          icon: Icons.flash_on_rounded,
                          title: l10n.dashboardNoQuickTasksTitle,
                          message: l10n.dashboardNoQuickTasksMessage,
                        ),
                        const SizedBox(height: 8),
                        AddTaskButton(
                          tonal: false,
                          onPressed: () {
                            controller.clearFields();
                            showTaskBottomSheet(context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: controller.tasks.map((task) {
                      return TaskItem(
                        task: task,
                        onTap: () {
                          controller.clearFields();
                          showTaskBottomSheet(Get.context!, task: task);
                        },
                        confirmDismiss: (direction) =>
                            _confirmDeleteTask(context, task),
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
                      );
                    }).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  Future<bool> _confirmDeleteTask(BuildContext context, TaskEntity task) async {
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

  Widget _buildTaskGroupsHeader(BuildContext context, ThemeData theme) {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          l10n.dashboardGroupsTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AddGroupButton(
          label: l10n.dashboardNewGroup,
          onPressed: () {
            controller.clearFields();
            showGroupBottomSheet(context);
          },
        ),
      ],
    );
  }

  Widget _buildTaskGroupsGrid(
    BuildContext context,
    ThemeData theme,
    double screenWidth,
  ) {
    // Os dados dos grupos devem vir do presenter
    final crossAxisCount = screenWidth > 600 ? 4 : 2;

    return Obx(
      () => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final group = controller.groups[index];
          return GroupCard(
            group: group,
            onTap: () async {
              await Get.toNamed(Routes.group.replaceAll(':id', group.id));
              await controller.loadAllData();
            },
          );
        }, childCount: controller.groups.length),
      ),
    );
  }
}
