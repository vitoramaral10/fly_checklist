import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/data/models/models.dart';
import 'package:fly_checklist/domain/entities/entities.dart';

void main() {
  GroupEntity makeEntity({DateTime? lastResetAt}) => GroupEntity(
    id: 'any_group_id',
    name: 'Mochila',
    description: 'Antes de sair',
    icon: defaultGroupIcon,
    color: Colors.blue,
    saveCheckState: false,
    createdAt: DateTime(2026, 1, 1),
    lastResetAt: lastResetAt,
  );

  test(
    'Should keep lastResetAt on the entity -> json -> entity round trip',
    () {
      final lastResetAt = DateTime(2026, 5, 10, 7, 30);
      final json = GroupModel.fromEntity(
        makeEntity(lastResetAt: lastResetAt),
      ).toJson();

      expect(json['lastResetAt'], Timestamp.fromDate(lastResetAt));

      // `id` não faz parte do documento: é adicionado pelo adapter na leitura.
      json['id'] = 'any_group_id';
      final entity = GroupModel.fromJson(json).toEntity();

      expect(entity.lastResetAt, lastResetAt);
      expect(entity.saveCheckState, false);
    },
  );

  test('Should read a group document without lastResetAt as null', () {
    final json = GroupModel.fromEntity(makeEntity()).toJson()
      ..['id'] = 'any_group_id'
      ..remove('lastResetAt');

    final entity = GroupModel.fromJson(json).toEntity();

    expect(entity.lastResetAt, null);
  });
}
