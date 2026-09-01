import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/entities/task_entity.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
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
                (task != null) ? 'Editar Tarefa' : 'Nova Tarefa',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'Insira os detalhes da nova tarefa aqui.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: controller.taskTitleController,
                decoration: const InputDecoration(
                  labelText: 'Título da Tarefa',
                  prefixIcon: Icon(Icons.title_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira o título da tarefa.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.taskDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição da Tarefa',
                  prefixIcon: Icon(Icons.description_outlined),
                  border: OutlineInputBorder(
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
                decoration: const InputDecoration(
                  labelText: 'Data de Vencimento',
                  prefixIcon: Icon(Icons.date_range_outlined),
                  border: OutlineInputBorder(
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
                      return 'A data não pode ser anterior a hoje.';
                    }
                  } on FormatException {
                    return 'Data inválida.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(
                () => DropdownButtonFormField<String?>(
                  initialValue: controller.taskGroupId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Grupo (opcional)',
                    prefixIcon: Icon(Icons.folder_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Sem grupo'),
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
                  decoration: const InputDecoration(
                    labelText: 'Prioridade',
                    prefixIcon: Icon(Icons.priority_high_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Sem prioridade')),
                    DropdownMenuItem(value: 1, child: Text('Baixa')),
                    DropdownMenuItem(value: 2, child: Text('Média')),
                    DropdownMenuItem(value: 3, child: Text('Alta')),
                    DropdownMenuItem(value: 4, child: Text('Crítica')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.taskPriority = value;
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione a prioridade da tarefa.';
                    }
                    if (value < 0 || value > 4) {
                      return 'Prioridade deve estar entre 0 e 4.';
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
                            message: (task != null)
                                ? 'Tarefa atualizada com sucesso!'
                                : 'Tarefa criada com sucesso!',
                          );
                        }
                      } on UiError catch (e) {
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) {
                          showErrorDialog(context, e.message);
                        }
                      }
                    }
                  },
                  child: Text((task != null) ? 'Atualizar' : 'Criar'),
                ),
              ),
              const SizedBox(height: 12),
              if (task != null)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text(
                      'Excluir',
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: () async {
                      final isDelete = await showConfirmationDialog(
                        context,
                        title: 'Excluir Tarefa',
                        content:
                            'Tem certeza que deseja excluir esta tarefa? Esta ação não pode ser desfeita.',
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
                            message: 'Tarefa excluída com sucesso!',
                          );
                        }
                      } on UiError catch (e) {
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) {
                          showErrorDialog(context, e.message);
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
