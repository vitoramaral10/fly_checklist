import 'package:flutter/material.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:get/get.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../components/components.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/ui_error_translation.dart';
import '../../group_form_presenter.dart';

Future<void> showGroupBottomSheet(
  BuildContext context, {
  GroupEntity? group,
  GroupFormPresenter? presenter,
  VoidCallback? onDeleted,
}) async {
  await showAppBottomSheet(
    context,
    isScrollControlled: true,
    builder: (context) => GroupBottomSheet(
      group: group,
      presenter: presenter,
      onDeleted: onDeleted,
    ),
  );
}

class GroupBottomSheet extends StatefulWidget {
  final GroupEntity? group;
  final GroupFormPresenter? presenter;
  final VoidCallback? onDeleted;

  const GroupBottomSheet({
    super.key,
    this.group,
    this.presenter,
    this.onDeleted,
  });

  @override
  State<GroupBottomSheet> createState() => _GroupBottomSheetState();
}

class _GroupBottomSheetState extends State<GroupBottomSheet> {
  late final GroupFormPresenter controller;

  @override
  void initState() {
    super.initState();

    controller = widget.presenter ?? Get.find<GetxDashboardPresenter>();

    // Preencher campos se estiver editando
    final group = widget.group;
    if (group != null) {
      controller.groupNameController.text = group.name;
      controller.groupDescriptionController.text = group.description ?? '';
      controller.groupIcon = group.icon;
      controller.groupColor = group.color;
      controller.saveCheckState = group.saveCheckState;
    }
  }

  /// Grupos só são criados a partir do dashboard; as demais páginas abrem este
  /// formulário apenas em modo de edição.
  Future<void> _saveGroup(GroupEntity? group) {
    if (group == null) {
      return Get.find<GetxDashboardPresenter>().onCreateGroup();
    }

    return controller.onUpdateGroup(
      group.copyWith(
        name: controller.groupNameController.text,
        description: controller.groupDescriptionController.text,
        icon: controller.groupIcon,
        color: controller.groupColor,
        saveCheckState: controller.saveCheckState,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final group = widget.group;

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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 20),
        child: Form(
          key: controller.formNewGroupKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título do modal
              Text(
                (group != null)
                    ? l10n.groupSheetEditTitle
                    : l10n.groupSheetCreateTitle,
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.groupSheetSubtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Campo Nome do Grupo
              TextFormField(
                controller: controller.groupNameController,
                decoration: InputDecoration(
                  labelText: l10n.groupFieldNameLabel,
                  prefixIcon: const Icon(Icons.label_outline),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.validatorGroupNameRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Descrição (opcional)
              TextFormField(
                controller: controller.groupDescriptionController,
                decoration: InputDecoration(
                  labelText: l10n.groupFieldDescriptionLabel,
                  prefixIcon: const Icon(Icons.description_outlined),
                  border: const OutlineInputBorder(
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
                          l10n.groupColorLabel,
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
                                        availableColor.computeLuminance() > 0.5
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
                        Icon(Icons.apps_outlined, color: colorScheme.onSurface),
                        const SizedBox(width: 12),
                        Text(
                          l10n.groupIconLabel,
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
                      children: groupIcons.map((availableIcon) {
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
                              l10n.groupSaveCheckStateTitle,
                              style: theme.textTheme.titleSmall,
                            ),
                            Text(
                              controller.saveCheckState
                                  ? l10n.groupSaveCheckStateOn
                                  : l10n.groupSaveCheckStateOff,
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

                        await _saveGroup(group);

                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) Navigator.of(context).pop();

                        if (context.mounted) {
                          showSuccessSnackbar(
                            context,
                            message: (group != null)
                                ? l10n.groupUpdatedSuccess
                                : l10n.groupCreatedSuccess,
                          );
                        }
                      } on UiError catch (e) {
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) {
                          showErrorDialog(context, e.message(context));
                        }
                      } catch (e) {
                        if (context.mounted) Navigator.of(context).pop();
                        if (context.mounted) {
                          showErrorDialog(
                            context,
                            l10n.groupSaveUnexpectedError,
                          );
                        }
                      }
                    }
                  },
                  child: Text(
                    (group != null)
                        ? l10n.groupSheetUpdateButton
                        : l10n.groupSheetCreateButton,
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
                    label: Text(
                      l10n.groupDelete,
                      style: const TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: () async {
                      final isDelete = await showConfirmationDialog(
                        context,
                        title: l10n.groupDelete,
                        content: l10n.groupDeleteConfirmContent,
                        destructive: true,
                      );

                      if (isDelete) {
                        try {
                          if (context.mounted) showLoadingDialog(context);
                          await controller.onDeleteGroup(group);
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) Navigator.of(context).pop();
                          widget.onDeleted?.call();
                          if (context.mounted) {
                            showSuccessSnackbar(
                              context,
                              message: l10n.groupDeletedSuccess,
                            );
                          }
                        } on UiError catch (e) {
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) {
                            showErrorDialog(context, e.message(context));
                          }
                        } catch (e) {
                          if (context.mounted) Navigator.of(context).pop();
                          if (context.mounted) {
                            showErrorDialog(context, l10n.groupDeleteError);
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
    );
  }
}
