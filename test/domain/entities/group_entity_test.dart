import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:fly_checklist/domain/helpers/helpers.dart';

void main() {
  late DateTime createdAt;

  GroupEntity makeSut({
    String name = 'Compras',
    String? description,
    IconData icon = defaultGroupIcon,
    Color color = Colors.blue,
    bool saveCheckState = false,
    DateTime? updatedAt,
    int completedTasks = 0,
    int totalTasks = 0,
  }) {
    return GroupEntity(
      id: 'any_id',
      name: name,
      description: description,
      icon: icon,
      color: color,
      saveCheckState: saveCheckState,
      createdAt: createdAt,
      updatedAt: updatedAt,
      completedTasks: completedTasks,
      totalTasks: totalTasks,
    );
  }

  setUp(() {
    createdAt = DateTime(2026, 1, 1);
  });

  test('Should throw DomainError.invalidName if name is empty', () {
    GroupEntity sut() => makeSut(name: '');

    expect(sut, throwsA(DomainError.invalidName));
  });

  test('Should throw DomainError.invalidName if name is only whitespace', () {
    GroupEntity sut() => makeSut(name: '   ');

    expect(sut, throwsA(DomainError.invalidName));
  });

  test(
    'Should update completedTasks and totalTasks when copyWith is called',
    () {
      final group = makeSut(completedTasks: 1, totalTasks: 5);

      final result = group.copyWith(completedTasks: 3, totalTasks: 8);

      expect(result.completedTasks, 3);
      expect(result.totalTasks, 8);
    },
  );

  test(
    'Should preserve completedTasks and totalTasks when copyWith is called without them',
    () {
      final group = makeSut(completedTasks: 2, totalTasks: 4);

      final result = group.copyWith(name: 'Casa');

      expect(result.completedTasks, group.completedTasks);
      expect(result.totalTasks, group.totalTasks);
    },
  );
}
