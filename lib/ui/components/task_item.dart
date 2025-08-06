import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback? onTap;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;

  const TaskItem({
    super.key,
    required this.task,
    required this.onCheckboxChanged,
    this.onTap,
    this.confirmDismiss,
  });

  @override
  Widget build(BuildContext context) {
    IconData priorityIcon;
    Color priorityColor;
    switch (task.priority) {
      case 4:
        priorityIcon = Icons.priority_high_rounded;
        priorityColor = Colors.red;
        break;
      case 3:
        priorityIcon = Icons.arrow_upward_rounded;
        priorityColor = Colors.orange;
        break;
      case 2:
        priorityIcon = Icons.drag_handle_rounded;
        priorityColor = Colors.amber;
        break;
      case 1:
        priorityIcon = Icons.arrow_downward_rounded;
        priorityColor = Colors.green;
        break;
      default:
        priorityIcon = Icons.low_priority_rounded;
        priorityColor = Colors.grey;
    }

    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: confirmDismiss,
      background: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete_rounded,
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: theme.colorScheme.outlineVariant.withAlpha(100),
          ),
        ),
        child: ListTile(
          dense: true,
          leading: Icon(priorityIcon, color: priorityColor),
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
          trailing: Checkbox(value: task.isDone, onChanged: onCheckboxChanged),
          onTap: onTap,
        ),
      ),
    );
  }
}
