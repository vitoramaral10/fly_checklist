import 'package:flutter/material.dart';

/// Ícone usado quando nenhum outro é escolhido ou quando o `codePoint`
/// persistido não pertence ao catálogo.
const IconData defaultGroupIcon = Icons.checklist_rounded;

/// Catálogo de ícones que podem ser escolhidos para um grupo.
///
/// Precisa ser uma lista de instâncias `const` para que o tree-shaking de
/// ícones do build release continue funcionando.
const List<IconData> groupIcons = <IconData>[
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

/// Ícones que já foram gravados por versões anteriores do app e continuam
/// sendo reconhecidos na leitura, mesmo não estando mais disponíveis para
/// seleção.
const List<IconData> _legacyGroupIcons = <IconData>[
  Icons.checklist,
  Icons.list_alt,
  Icons.task_alt,
];

IconData groupIconFromCodePoint(int codePoint) {
  for (final icon in groupIcons) {
    if (icon.codePoint == codePoint) return icon;
  }
  for (final icon in _legacyGroupIcons) {
    if (icon.codePoint == codePoint) return icon;
  }
  return defaultGroupIcon;
}
