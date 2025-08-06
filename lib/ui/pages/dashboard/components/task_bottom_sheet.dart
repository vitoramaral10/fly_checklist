import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/entities/task_entity.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../components/components.dart';
import '../../../helpers/helpers.dart';

Future<void> showTaskBottomSheet(
  BuildContext context, {
  TaskEntity? task,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return TaskBottomSheet(task: task);
    },
  );
}

class TaskBottomSheet extends GetView<GetxDashboardPresenter> {
  final TaskEntity? task;

  const TaskBottomSheet({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (task != null) {
      controller.newTaskTitleController.text = task!.title;
      controller.newTaskDescriptionController.text = task!.description;
      controller.newTaskDueDateController.text =
          task!.dueDate?.toLocal().toString().split(' ')[0] ?? '';
      controller.newTaskPriority = task!.priority;
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: controller.formNewTaskKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withAlpha(100),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
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
                  controller: controller.newTaskTitleController,
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
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o título da tarefa.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.newTaskDescriptionController,
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
                  controller: controller.newTaskDueDateController,
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
                      controller.newTaskDueDateController.text = DateFormat.yMd(
                        'pt_BR',
                      ).format(selectedDate);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: controller.newTaskPriority,
                  decoration: const InputDecoration(
                    labelText: 'Prioridade',
                    prefixIcon: Icon(Icons.priority_high_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('Baixa')),
                    DropdownMenuItem(value: 2, child: Text('Média')),
                    DropdownMenuItem(value: 3, child: Text('Alta')),
                    DropdownMenuItem(value: 4, child: Text('Crítica')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.newTaskPriority = value;
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione a prioridade da tarefa.';
                    }
                    return null;
                  },
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
                            await controller.onUpdateTask(
                              task!.copyWith(
                                title: controller.newTaskTitleController.text,
                                description: controller
                                    .newTaskDescriptionController
                                    .text,
                                dueDate: DateTime.tryParse(
                                  controller.newTaskDueDateController.text,
                                ),
                                priority: controller.newTaskPriority ?? 2,
                              ),
                            );
                          } else {
                            await controller.createNewTask();
                          }
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) Navigator.of(context).pop();

                          if (context.mounted) {
                            showSuccessDialog(
                              context,
                              (task != null)
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
