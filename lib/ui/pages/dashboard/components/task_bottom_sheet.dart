import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/entities/task_entity.dart';
import 'package:get/get.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/ui_error_translation.dart';
import '../../task_form_presenter.dart';

Future<void> showTaskBottomSheet(
  BuildContext context, {
  TaskEntity? task,
  TaskFormPresenter? presenter,
  String? groupId,
}) async {
  await showAppBottomSheet(
    context,
    builder: (context) =>
        TaskBottomSheet(task: task, presenter: presenter, groupId: groupId),
  );
}

class TaskBottomSheet extends StatefulWidget {
  final TaskEntity? task;
  final TaskFormPresenter? presenter;
  final String? groupId;

  const TaskBottomSheet({super.key, this.task, this.presenter, this.groupId});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  late final TaskFormPresenter controller;

  @override
  void initState() {
    super.initState();

    controller = widget.presenter ?? Get.find<GetxDashboardPresenter>();

    final task = widget.task;
    if (task != null) {
      controller.taskTitleController.text = task.title;
      controller.taskDescriptionController.text = task.description;
      controller.taskDueDateController.text = task.dueDate != null
          ? appDateFormat.format(task.dueDate!)
          : '';
      controller.taskPriority = task.priority;
    }

    final groupId = task?.groupId ?? widget.groupId;
    controller.taskGroupId =
        controller.groups.any((group) => group.id == groupId) ? groupId : null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final task = widget.task;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 20),
        child: Form(
          key: controller.formNewTaskKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                (task != null)
                    ? l10n.taskSheetEditTitle
                    : l10n.taskSheetCreateTitle,
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.taskSheetSubtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: controller.taskTitleController,
                decoration: InputDecoration(
                  labelText: l10n.taskFieldTitleLabel,
                  prefixIcon: const Icon(Icons.title_outlined),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.validatorTaskTitleRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.taskDescriptionController,
                decoration: InputDecoration(
                  labelText: l10n.taskFieldDescriptionLabel,
                  prefixIcon: const Icon(Icons.description_outlined),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.taskDueDateController,
                decoration: InputDecoration(
                  labelText: l10n.taskFieldDueDateLabel,
                  prefixIcon: const Icon(Icons.date_range_outlined),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.done,
                readOnly: true,
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    controller.taskDueDateController.text = appDateFormat
                        .format(selectedDate);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  try {
                    final date = appDateFormat.parseStrict(value);
                    if (isDateInPast(date)) {
                      return l10n.validatorDueDateInPast;
                    }
                  } on FormatException {
                    return l10n.validatorDueDateInvalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(
                () => DropdownButtonFormField<String?>(
                  initialValue: controller.taskGroupId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l10n.taskFieldGroupLabel,
                    prefixIcon: const Icon(Icons.folder_outlined),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  items: [
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text(l10n.taskGroupNone),
                    ),
                    ...controller.groups.map(
                      (group) => DropdownMenuItem<String?>(
                        value: group.id,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(group.icon, size: 18, color: group.color),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                group.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    controller.taskGroupId = value;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => DropdownButtonFormField<int>(
                  initialValue: controller.taskPriority,
                  decoration: InputDecoration(
                    labelText: l10n.taskFieldPriorityLabel,
                    prefixIcon: const Icon(Icons.priority_high_outlined),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text(l10n.taskPriorityNone),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text(l10n.taskPriorityLow),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text(l10n.taskPriorityMedium),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text(l10n.taskPriorityHigh),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text(l10n.taskPriorityCritical),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.taskPriority = value;
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return l10n.validatorPriorityRequired;
                    }
                    if (value < 0 || value > 4) {
                      return l10n.validatorPriorityRange;
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (controller.formNewTaskKey.currentState!.validate()) {
                      try {
                        showLoadingDialog(context);
                        if (task != null) {
                          final dueDateText =
                              controller.taskDueDateController.text;
                          await controller.onUpdateTask(
                            task.copyWith(
                              title: controller.taskTitleController.text,
                              description:
                                  controller.taskDescriptionController.text,
                              groupId: controller.taskGroupId,
                              dueDate: dueDateText.isNotEmpty
                                  ? appDateFormat.parse(dueDateText)
                                  : null,
                              priority: controller.taskPriority ?? 2,
                            ),
                          );
                        } else {
                          await controller.onCreateTask();
                        }
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) Navigator.of(context).pop();

                        if (context.mounted) {
                          showSuccessSnackbar(
                            context,
                            message: (task != null)
                                ? l10n.taskUpdatedSuccess
                                : l10n.taskCreatedSuccess,
                          );
                        }
                      } on UiError catch (e) {
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) {
                          showErrorDialog(context, e.message(context));
                        }
                      }
                    }
                  },
                  child: Text(
                    (task != null) ? l10n.commonUpdate : l10n.commonCreate,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (task != null)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: Text(
                      l10n.commonDelete,
                      style: const TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: () async {
                      final isDelete = await showConfirmationDialog(
                        context,
                        title: l10n.taskDeleteConfirmTitle,
                        content: l10n.taskDeleteConfirmContent,
                        destructive: true,
                      );

                      if (!isDelete) return;

                      try {
                        if (context.mounted) showLoadingDialog(context);
                        await controller.onDeleteTask(task);
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) Navigator.of(context).pop();

                        if (context.mounted) {
                          showSuccessSnackbar(
                            context,
                            message: l10n.taskDeletedSuccess,
                          );
                        }
                      } on UiError catch (e) {
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) {
                          showErrorDialog(context, e.message(context));
                        }
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
