import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/entities/entities.dart';

import '../../l10n/generated/app_localizations.dart';
import '../helpers/helpers.dart';

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
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    // Tons fixos, mas escolhidos aos pares (escuro no claro, claro no
    // escuro) para manter contraste suficiente com o fundo do Card nos dois
    // brightness — a cor em si não muda de acordo com o tema, só o tom.
    final isDark = theme.brightness == Brightness.dark;

    IconData priorityIcon;
    Color priorityColor;
    String priorityLabel;
    switch (task.priority) {
      case 4:
        priorityIcon = Icons.priority_high_rounded;
        priorityColor = isDark ? Colors.red.shade300 : Colors.red.shade700;
        priorityLabel = l10n.taskPriorityCritical;
        break;
      case 3:
        priorityIcon = Icons.arrow_upward_rounded;
        priorityColor = isDark
            ? Colors.orange.shade300
            : Colors.orange.shade800;
        priorityLabel = l10n.taskPriorityHigh;
        break;
      case 2:
        priorityIcon = Icons.drag_handle_rounded;
        priorityColor = isDark
            ? Colors.amber.shade300
            : Colors.amber.shade800;
        priorityLabel = l10n.taskPriorityMedium;
        break;
      case 1:
        priorityIcon = Icons.arrow_downward_rounded;
        priorityColor = isDark
            ? Colors.green.shade300
            : Colors.green.shade700;
        priorityLabel = l10n.taskPriorityLow;
        break;
      default:
        priorityIcon = Icons.low_priority_rounded;
        priorityColor = theme.colorScheme.onSurfaceVariant;
        priorityLabel = l10n.taskPriorityNone;
    }

    final checkboxLabel = task.isDone
        ? l10n.taskCheckboxLabelDone(task.title)
        : l10n.taskCheckboxLabelPending(task.title);

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
        margin: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete_rounded,
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: theme.colorScheme.outlineVariant.withAlpha(100),
          ),
        ),
        child: ListTile(
          dense: true,
          leading: Icon(
            priorityIcon,
            color: priorityColor,
            semanticLabel: l10n.taskPrioritySemanticLabel(priorityLabel),
          ),
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
                  appDateFormat.format(task.dueDate!),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
          // O rótulo repõe o título e o estado (perdidos pelo leitor de tela
          // no tachado visual) junto do papel/estado nativos do Checkbox.
          trailing: Semantics(
            label: checkboxLabel,
            child: Checkbox(value: task.isDone, onChanged: onCheckboxChanged),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
