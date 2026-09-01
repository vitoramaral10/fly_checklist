import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

/// Contrato do formulário de grupos, compartilhado por todas as páginas que
/// abrem o `GroupBottomSheet`. A criação de grupos acontece apenas no
/// dashboard, por isso não faz parte deste contrato.
abstract class GroupFormPresenter {
  GlobalKey<FormState> get formNewGroupKey;
  TextEditingController get groupNameController;
  TextEditingController get groupDescriptionController;
  IconData get groupIcon;
  Color get groupColor;
  bool get saveCheckState;

  set groupIcon(IconData value);
  set groupColor(Color value);
  set saveCheckState(bool value);

  void clearFields();

  Future<void> onUpdateGroup(GroupEntity group);
  Future<void> onDeleteGroup(GroupEntity group);
}
