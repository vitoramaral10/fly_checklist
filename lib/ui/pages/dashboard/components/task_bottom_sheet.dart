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
  await showAppBottomSheet(
    context,
    builder: (context) => TaskBottomSheet(task: task),
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
      controller.taskTitleController.text = task!.title;
      controller.taskDescriptionController.text = task!.description;
      controller.taskDueDateController.text = (task!.dueDate != null)
          ? DateFormat.yMd().format(task!.dueDate!)
          : '';
      controller.taskPriority = task!.priority;
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 0,
            bottom: 20,
          ),
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
                    if (value == null || value.isEmpty) {
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
                      controller.taskDueDateController.text = DateFormat.yMd(
                        'pt_BR',
                      ).format(selectedDate);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Obx(
                  () => DropdownButtonFormField<int>(
                    value: controller.taskPriority,
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
                        controller.taskPriority = value;
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor, selecione a prioridade da tarefa.';
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
                            await controller.onUpdateTask(
                              task!.copyWith(
                                title: controller.taskTitleController.text,
                                description:
                                    controller.taskDescriptionController.text,
                                dueDate: DateTime.tryParse(
                                  controller.taskDueDateController.text,
                                ),
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
                        );

                        if (isDelete) {
                          await controller.onDeleteTask(task!);
                          if (context.mounted) Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
