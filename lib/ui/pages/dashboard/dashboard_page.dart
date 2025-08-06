import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/entities/task_entity.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            controller.clearNewTaskFields();
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
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tarefas Rápidas',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          controller.tasks.isEmpty
              ? Text(
                  'Nenhuma tarefa rápida disponível.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              : Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: controller.tasks.map((task) {
                      return _buildQuickTaskItem(theme, task);
                    }).toList(),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildQuickTaskItem(ThemeData theme, TaskEntity task) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withAlpha(100),
        ),
      ),
      child: ListTile(
        dense: true,
        title: Text(
          task.title,
          style: theme.textTheme.bodyLarge?.copyWith(
            decoration: task.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: task.isDone
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onSurface,
          ),
        ),
        subtitle: task.dueDate != null
            ? Text(
                DateFormat.yMd().format(task.dueDate!),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            : null,
        trailing: Checkbox(
          value: task.isDone,
          onChanged: (bool? value) async {
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
        onTap: () {
          controller.clearNewTaskFields();
          showTaskBottomSheet(Get.context!, task: task);
        },
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
        IconButton(
          icon: const Icon(Icons.add_circle_outline_rounded),
          onPressed: () {
            // TODO: Implementar a lógica para adicionar um novo grupo
          },
          tooltip: 'Adicionar Grupo',
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
    final items = [
      _buildTaskGroupCard(
        theme,
        'Trabalho',
        5,
        8,
        Colors.orange.shade300,
        Icons.work_rounded,
      ),
      _buildTaskGroupCard(
        theme,
        'Pessoal',
        2,
        10,
        Colors.blue.shade300,
        Icons.person_rounded,
      ),
      _buildTaskGroupCard(
        theme,
        'Estudos',
        7,
        7,
        Colors.green.shade300,
        Icons.school_rounded,
      ),
      _buildTaskGroupCard(
        theme,
        'Casa',
        1,
        3,
        Colors.pink.shade200,
        Icons.home_rounded,
      ),
      _buildTaskGroupCard(
        theme,
        'Fitness',
        4,
        5,
        Colors.teal.shade300,
        Icons.fitness_center_rounded,
      ),
      _buildTaskGroupCard(
        theme,
        'Compras',
        9,
        12,
        Colors.purple.shade200,
        Icons.shopping_bag_rounded,
      ),
    ];

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => items[index],
        childCount: items.length,
      ),
    );
  }

  Widget _buildTaskGroupCard(
    ThemeData theme,
    String title,
    int completed,
    int total,
    Color color,
    IconData icon,
  ) {
    final progress = total > 0 ? completed / total : 0.0;
    return Card(
      elevation: 0,
      color: color.withAlpha(40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          // TODO: Navegar para a tela de detalhes do grupo
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withAlpha(80),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color.withAlpha(200), size: 28),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$completed/$total tarefas',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: color.withAlpha(60),
                    color: color,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
