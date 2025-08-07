import 'package:flutter/material.dart';

class GroupEntity {
  final String id;
  final String name;
  final String? description;
  final IconData icon;
  final Color color;
  final bool saveCheckState;
  final DateTime createdAt;
  final DateTime? updatedAt;
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
    this.completedTasks = 0,
    this.totalTasks = 0,
  });

  GroupEntity copyWith({
    String? name,
    String? description,
    IconData? icon,
    Color? color,
    bool? saveCheckState,
    DateTime? updatedAt,
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
    );
  }
}
