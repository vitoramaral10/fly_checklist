import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: _buildHeader(context, theme),
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
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementar ação de adicionar nova tarefa
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    // Os dados do usuário (nome e foto) devem vir do presenter
    return Row(
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
              'Vitor', // TODO: Substituir pelo nome do usuário
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // TODO: Navegar para a tela de configurações
            // Get.toNamed('/settings');
          },
          child: const CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?u=a042581f4e29026704d',
            ), // TODO: Substituir pela foto do usuário
          ),
        ),
      ],
    );
  }

  Widget _buildQuickTasks(BuildContext context, ThemeData theme) {
    // Os dados das tarefas rápidas devem vir do presenter
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lembretes Rápidos',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildQuickTaskItem(theme, 'Comprar pão para o café da manhã', true),
        const SizedBox(height: 8),
        _buildQuickTaskItem(theme, 'Reunião de equipe às 14h no Zoom', false),
        const SizedBox(height: 8),
        _buildQuickTaskItem(theme, 'Ligar para o cliente da empresa X', false),
      ],
    );
  }

  Widget _buildQuickTaskItem(ThemeData theme, String title, bool isDone) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withAlpha(100),
        ),
      ),
      child: ListTile(
        leading: Icon(
          isDone
              ? Icons.check_box_rounded
              : Icons.check_box_outline_blank_rounded,
          color: isDone
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            decoration: isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: isDone
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onSurface,
          ),
        ),
        onTap: () {
          // TODO: Implementar a lógica para marcar/desmarcar a tarefa
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
