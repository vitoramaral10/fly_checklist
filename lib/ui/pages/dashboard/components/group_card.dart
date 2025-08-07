import 'package:flutter/material.dart';

import '../../../../domain/entities/entities.dart';

class GroupCard extends StatelessWidget {
  final GroupEntity group;

  const GroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final progress = group.totalTasks > 0
        ? group.completedTasks / group.totalTasks
        : 0.0;
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: group.color.withAlpha(40),
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
                  color: group.color.withAlpha(80),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  group.icon,
                  color: group.color.withAlpha(200),
                  size: 28,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${group.completedTasks}/${group.totalTasks} tarefas',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: group.color.withAlpha(60),
                    color: group.color,
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
