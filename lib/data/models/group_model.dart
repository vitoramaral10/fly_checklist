import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

class GroupModel {
  final String id;
  final String name;
  final String? description;
  final int icon;
  final int colorValue;
  final bool saveCheckState;
  final DateTime createdAt;
  final DateTime? updatedAt;

  GroupModel({
    required this.id,
    required this.name,
    this.description,
    required this.icon,
    required this.colorValue,
    required this.saveCheckState,
    required this.createdAt,
    this.updatedAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      icon: json['icon'] as int,
      colorValue: json['colorValue'] as int,
      saveCheckState: json['saveCheckState'] as bool? ?? true,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  GroupEntity toEntity() {
    return GroupEntity(
      id: id,
      name: name,
      description: description,
      icon: IconData(icon, fontFamily: 'MaterialIcons'),
      color: Color(colorValue),
      saveCheckState: saveCheckState,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'icon': icon,
      'colorValue': colorValue,
      'saveCheckState': saveCheckState,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  factory GroupModel.fromEntity(GroupEntity entity) {
    return GroupModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      icon: entity.icon.codePoint,
      colorValue: entity.color.toARGB32(),
      saveCheckState: entity.saveCheckState,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
