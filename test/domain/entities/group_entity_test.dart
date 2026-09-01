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
    DateTime? lastResetAt,
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
      lastResetAt: lastResetAt,
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

  test('Should preserve lastResetAt when copyWith is called without it', () {
    final lastResetAt = DateTime(2026, 5, 10, 8);
    final group = makeSut(lastResetAt: lastResetAt);

    final result = group.copyWith(name: 'Casa');

    expect(result.lastResetAt, lastResetAt);
  });

  test('Should update lastResetAt when copyWith is called with it', () {
    final group = makeSut(lastResetAt: DateTime(2026, 5, 10, 8));
    final newLastResetAt = DateTime(2026, 5, 11, 7);

    final result = group.copyWith(lastResetAt: newLastResetAt);

    expect(result.lastResetAt, newLastResetAt);
  });

  group('isReusableChecklist', () {
    test('Should be true when saveCheckState is false', () {
      expect(makeSut(saveCheckState: false).isReusableChecklist, true);
    });

    test('Should be false when saveCheckState is true', () {
      expect(makeSut(saveCheckState: true).isReusableChecklist, false);
    });
  });

  group('needsDailyReset', () {
    final now = DateTime(2026, 5, 11, 9, 30);

    test('Should be false when saveCheckState is true, even after a day', () {
      final sut = makeSut(
        saveCheckState: true,
        lastResetAt: DateTime(2026, 5, 10, 23, 59),
      );

      expect(sut.needsDailyReset(now: now), false);
    });

    test('Should be true when last reset happened on a previous day', () {
      final sut = makeSut(lastResetAt: DateTime(2026, 5, 10, 23, 59));

      expect(sut.needsDailyReset(now: now), true);
    });

    test(
      'Should be false when last reset happened earlier on the same day',
      () {
        final sut = makeSut(lastResetAt: DateTime(2026, 5, 11, 0, 1));

        expect(sut.needsDailyReset(now: now), false);
      },
    );

    test('Should be false when last reset happened later on the same day', () {
      final sut = makeSut(lastResetAt: DateTime(2026, 5, 11, 23, 59));

      expect(sut.needsDailyReset(now: now), false);
    });

    test(
      'Should fall back to createdAt and be true when group was created on a previous day',
      () {
        createdAt = DateTime(2026, 5, 10, 20);
        final sut = makeSut(lastResetAt: null);

        expect(sut.needsDailyReset(now: now), true);
      },
    );

    test(
      'Should fall back to createdAt and be false when group was created on the same day',
      () {
        createdAt = DateTime(2026, 5, 11, 8);
        final sut = makeSut(lastResetAt: null);

        expect(sut.needsDailyReset(now: now), false);
      },
    );

    test('Should be true when last reset happened months earlier', () {
      final sut = makeSut(lastResetAt: DateTime(2025, 12, 31, 23, 59));

      expect(sut.needsDailyReset(now: now), true);
    });
  });
}
