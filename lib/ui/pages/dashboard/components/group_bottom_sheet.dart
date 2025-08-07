import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/entities/group_entity.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../components/components.dart';
import '../../../helpers/helpers.dart';

Future<void> showGroupBottomSheet(
  BuildContext context, {
  GroupEntity? group,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return GroupBottomSheet(group: group);
    },
  );
}

class GroupBottomSheet extends GetView<GetxDashboardPresenter> {
  final GroupEntity? group;

  const GroupBottomSheet({super.key, this.group});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Cores predefinidas para seleção
    final availableColors = [
      colorScheme.primary,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.brown,
    ];

    // Ícones predefinidos para seleção
    final availableIcons = [
      Icons.checklist_rounded,
      Icons.list_alt_rounded,
      Icons.task_alt_rounded,
      Icons.assignment_rounded,
      Icons.work_rounded,
      Icons.home_rounded,
      Icons.school_rounded,
      Icons.fitness_center_rounded,
      Icons.shopping_cart_rounded,
      Icons.restaurant_rounded,
      Icons.car_repair_rounded,
      Icons.flight_rounded,
      Icons.medical_services_rounded,
      Icons.pets_rounded,
      Icons.sports_soccer_rounded,
    ];

    // Preencher campos se estiver editando
    if (group != null) {
      controller.groupNameController.text = group!.name;
      controller.groupDescriptionController.text = group!.description ?? '';
      controller.groupIcon = group!.icon;
      controller.groupColor = group!.color;
      controller.saveCheckState = group!.saveCheckState;
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: controller.formNewGroupKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle visual
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withAlpha(100),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),

                // Título do modal
                Text(
                  (group != null) ? 'Editar Grupo' : 'Novo Grupo',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  'Configure os detalhes do seu grupo de tarefas.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),

                // Campo Nome do Grupo
                TextFormField(
                  controller: controller.groupNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Grupo',
                    prefixIcon: Icon(Icons.label_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira o nome do grupo.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo Descrição (opcional)
                TextFormField(
                  controller: controller.groupDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição (opcional)',
                    prefixIcon: Icon(Icons.description_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 16),

                // Seletor de Cor
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.palette_outlined,
                            color: colorScheme.onSurface,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Cor do Grupo',
                            style: theme.textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: controller.groupColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.outline,
                                width: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: availableColors.map((availableColor) {
                          final isSelected =
                              availableColor == controller.groupColor;
                          return GestureDetector(
                            onTap: () {
                              controller.groupColor = availableColor;
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: availableColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? colorScheme.onSurface
                                      : colorScheme.outline,
                                  width: isSelected ? 3 : 1,
                                ),
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.check,
                                      color:
                                          availableColor.computeLuminance() >
                                              0.5
                                          ? Colors.black
                                          : Colors.white,
                                      size: 20,
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Seletor de Ícone
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.apps_outlined,
                            color: colorScheme.onSurface,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Ícone do Grupo',
                            style: theme.textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: controller.groupColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              controller.groupIcon,
                              color:
                                  controller.groupColor.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: availableIcons.map((availableIcon) {
                          final isSelected =
                              availableIcon == controller.groupIcon;
                          return GestureDetector(
                            onTap: () {
                              controller.groupIcon = availableIcon;
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? colorScheme.primaryContainer
                                    : colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? colorScheme.primary
                                      : colorScheme.outline,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Icon(
                                availableIcon,
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
                                size: 24,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Switch para salvar estado dos checks
                Obx(
                  () => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.save_outlined, color: colorScheme.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Salvar Estado dos Checks',
                                style: theme.textTheme.titleSmall,
                              ),
                              Text(
                                controller.saveCheckState
                                    ? 'Os checks marcados serão mantidos entre sessões'
                                    : 'Os checks serão resetados a cada nova sessão',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: controller.saveCheckState,
                          onChanged: (value) {
                            controller.saveCheckState = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Botão de Ação Principal
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      if (controller.formNewGroupKey.currentState!.validate()) {
                        try {
                          showLoadingDialog(context);

                          // TODO: Implementar lógica de criação/atualização do grupo
                          // final newGroup = GroupEntity(
                          //   id: group?.id ?? '',
                          //   name: nameController.text.trim(),
                          //   description: descriptionController.text.trim().isEmpty
                          //       ? null
                          //       : descriptionController.text.trim(),
                          //   icon: selectedIcon.value,
                          //   color: selectedColor.value,
                          //   saveCheckState: saveCheckState.value,
                          //   createdAt: group?.createdAt ?? DateTime.now(),
                          //   updatedAt: group != null ? DateTime.now() : null,
                          // );

                          // if (group != null) {
                          //   await controller.onUpdateGroup(newGroup);
                          // } else {
                          //   await controller.createNewGroup(newGroup);
                          // }

                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) Navigator.of(context).pop();

                          if (context.mounted) {
                            showSuccessSnackbar(
                              message: (group != null)
                                  ? 'Grupo atualizado com sucesso!'
                                  : 'Grupo criado com sucesso!',
                            );
                          }
                        } on UiError catch (e) {
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) {
                            showErrorDialog(context, e.message);
                          }
                        } catch (e) {
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) {
                            showErrorDialog(
                              context,
                              'Erro inesperado ao salvar grupo',
                            );
                          }
                        }
                      }
                    },
                    child: Text(
                      (group != null) ? 'Atualizar Grupo' : 'Criar Grupo',
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Botão de Exclusão (apenas para edição)
                if (group != null)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      label: const Text(
                        'Excluir Grupo',
                        style: TextStyle(color: Colors.red),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                      ),
                      onPressed: () async {
                        final isDelete = await showConfirmationDialog(
                          context,
                          title: 'Excluir Grupo',
                          content:
                              'Tem certeza que deseja excluir este grupo? Todas as tarefas associadas também serão removidas. Esta ação não pode ser desfeita.',
                        );

                        if (isDelete) {
                          try {
                            if (context.mounted) showLoadingDialog(context);
                            // TODO: Implementar lógica de exclusão do grupo
                            // await controller.onDeleteGroup(group!);
                            if (context.mounted) Navigator.of(context).pop();
                            if (context.mounted) Navigator.of(context).pop();
                            if (context.mounted) {
                              showSuccessSnackbar(
                                message: 'Grupo excluído com sucesso!',
                              );
                            }
                          } catch (e) {
                            if (context.mounted) Navigator.of(context).pop();
                            if (context.mounted) {
                              showErrorDialog(context, 'Erro ao excluir grupo');
                            }
                          }
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
