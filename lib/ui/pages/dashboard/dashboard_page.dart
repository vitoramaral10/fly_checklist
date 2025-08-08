import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main/routes.dart';
import '../../../presentation/presenters/presenters.dart';
import '../../components/components.dart';
import '../pages.dart';

class DashboardPage extends GetView<GetxDashboardPresenter> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return const DashboardLoadingPage();
      }

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
                              'Olá,',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              controller.user!.name.split(' ')[0],
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
                          child: (controller.user?.photoUrl == null)
                              ? CircleAvatar(
                                  radius: 32,
                                  backgroundColor: theme.colorScheme.secondary,
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: theme.colorScheme.onSecondary,
                                    size: 32,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(
                                    controller.user!.photoUrl!,
                                  ),
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

  Widget _buildQuickTasks(BuildContext context, ThemeData theme) {
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
          const SectionHeader(title: 'Tarefas Rápidas'),
          const SizedBox(height: 16),
          controller.tasks.isEmpty
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmptyState(
                          icon: Icons.flash_on_rounded,
                          title: 'Nenhuma tarefa rápida',
                          message: 'Crie uma nova tarefa para começar.',
                        ),
                        const SizedBox(height: 8),
                        AddTaskButton(
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
                        confirmDismiss: (direction) async {
                          try {
                            final isDelete = await showConfirmationDialog(
                              context,
                              title: 'Excluir Tarefa',
                              content:
                                  'Tem certeza que deseja excluir esta tarefa? Esta ação não pode ser desfeita.',
                            );

                            if (isDelete) {
                              if (context.mounted) showLoadingDialog(context);
                              await controller.onDeleteTask(task);
                              if (context.mounted) Navigator.of(context).pop();
                              showSuccessSnackbar(
                                title: 'Tarefa excluída',
                                message:
                                    'A tarefa "${task.title}" foi excluída com sucesso.',
                              );
                              return true;
                            } else {
                              return false;
                            }
                          } catch (e) {
                            showErrorSnackbar(
                              'Erro ao excluir tarefa',
                              'Não foi possível excluir a tarefa. Tente novamente mais tarde.',
                            );
                            return false;
                          }
                        },
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
                      );
                    }).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTaskGroupsHeader(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Grupos de Tarefas',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AddGroupButton(
          label: 'Novo grupo',
          onPressed: () {
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
        delegate: SliverChildBuilderDelegate(
          (context, index) => GroupCard(group: controller.groups[index]),
          childCount: controller.groups.length,
        ),
      ),
    );
  }
}
