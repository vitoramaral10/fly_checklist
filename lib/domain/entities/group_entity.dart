import 'package:flutter/material.dart';

import '../helpers/helpers.dart';

class GroupEntity {
  final String id;
  final String name;
  final String? description;
  final IconData icon;
  final Color color;
  final bool saveCheckState;
  final DateTime createdAt;
  final DateTime? updatedAt;

  /// Momento em que os checks do grupo foram desmarcados pela última vez.
  ///
  /// Só faz sentido para checklists reutilizáveis ([saveCheckState] falso) e é
  /// o que evita reiniciar o mesmo grupo mais de uma vez no mesmo dia.
  final DateTime? lastResetAt;

  final int completedTasks;
  final int totalTasks;

  GroupEntity({
    required this.id,
    required this.name,
    this.description,
    required this.icon,
    required this.color,
    required this.saveCheckState,
    required this.createdAt,
    this.updatedAt,
    this.lastResetAt,
    this.completedTasks = 0,
    this.totalTasks = 0,
  }) {
    if (name.trim().isEmpty) {
      throw DomainError.invalidName;
    }
  }

  /// Grupo que se comporta como um checklist de voo: os checks não são para
  /// durar, o checklist é refeito a cada uso.
  bool get isReusableChecklist => !saveCheckState;

  /// Indica se os checks do grupo precisam ser desmarcados por virada de dia.
  ///
  /// Grupos que salvam o estado dos checks nunca são reiniciados
  /// automaticamente. Sem [lastResetAt], a data de criação serve de
  /// referência, para que um grupo criado hoje não nasça pedindo reset.
  ///
  /// [now] existe para os testes; em produção usa o relógio local, o mesmo
  /// fuso em que o usuário enxerga a virada do dia.
  bool needsDailyReset({DateTime? now}) {
    if (saveCheckState) return false;

    final reference = lastResetAt ?? createdAt;
    return _dateOnly(reference).isBefore(_dateOnly(now ?? DateTime.now()));
  }

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  GroupEntity copyWith({
    String? name,
    String? description,
    IconData? icon,
    Color? color,
    bool? saveCheckState,
    DateTime? updatedAt,
    DateTime? lastResetAt,
    int? completedTasks,
    int? totalTasks,
  }) {
    return GroupEntity(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      saveCheckState: saveCheckState ?? this.saveCheckState,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      lastResetAt: lastResetAt ?? this.lastResetAt,
      completedTasks: completedTasks ?? this.completedTasks,
      totalTasks: totalTasks ?? this.totalTasks,
    );
  }
}
