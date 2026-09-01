import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:fly_checklist/domain/helpers/helpers.dart';

void main() {
  late DateTime createdAt;

  TaskEntity makeSut({
    String title = 'Comprar leite',
    String? groupId,
    String description = 'Descrição da tarefa',
    DateTime? dueDate,
    int priority = 2,
    bool isDone = false,
  }) {
    return TaskEntity(
      id: 'any_id',
      groupId: groupId,
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
      isDone: isDone,
      createdAt: createdAt,
    );
  }

  setUp(() {
    createdAt = DateTime(2026, 1, 1);
  });

  group('construction', () {
    test(
      'Should not throw when dueDate is in the past',
      () {
        final pastDate = DateTime.now().subtract(const Duration(days: 10));

        TaskEntity sut() => makeSut(dueDate: pastDate);

        expect(sut, returnsNormally);
      },
    );

    test(
      'Should throw DomainError.invalidTitle if title is empty',
      () {
        TaskEntity sut() => makeSut(title: '');

        expect(sut, throwsA(DomainError.invalidTitle));
      },
    );

    test(
      'Should throw DomainError.invalidTitle if title is only whitespace',
      () {
        TaskEntity sut() => makeSut(title: '   ');

        expect(sut, throwsA(DomainError.invalidTitle));
      },
    );

    test(
      'Should throw DomainError.invalidPriority if priority is below minPriority',
      () {
        TaskEntity sut() => makeSut(priority: TaskEntity.minPriority - 1);

        expect(sut, throwsA(DomainError.invalidPriority));
      },
    );

    test(
      'Should throw DomainError.invalidPriority if priority is above maxPriority',
      () {
        TaskEntity sut() => makeSut(priority: TaskEntity.maxPriority + 1);

        expect(sut, throwsA(DomainError.invalidPriority));
      },
    );
  });

  group('copyWith', () {
    test('Should preserve every field when called with no arguments', () {
      final task = makeSut(
        groupId: 'group_1',
        dueDate: DateTime(2026, 5, 10),
        isDone: true,
      );

      final result = task.copyWith();

      expect(result.id, task.id);
      expect(result.groupId, task.groupId);
      expect(result.title, task.title);
      expect(result.description, task.description);
      expect(result.dueDate, task.dueDate);
      expect(result.priority, task.priority);
      expect(result.isDone, task.isDone);
      expect(result.createdAt, task.createdAt);
    });

    test('Should clear dueDate when copyWith is called with dueDate: null', () {
      final task = makeSut(dueDate: DateTime(2026, 5, 10));

      final result = task.copyWith(dueDate: null);

      expect(result.dueDate, isNull);
    });

    test('Should clear groupId when copyWith is called with groupId: null', () {
      final task = makeSut(groupId: 'group_1');

      final result = task.copyWith(groupId: null);

      expect(result.groupId, isNull);
    });

    test(
      'Should update isDone on a task whose dueDate is already overdue',
      () {
        final overdueTask = makeSut(
          dueDate: DateTime.now().subtract(const Duration(days: 3)),
          isDone: false,
        );

        final result = overdueTask.copyWith(isDone: true);

        expect(result.isDone, isTrue);
        expect(result.dueDate, overdueTask.dueDate);
      },
    );
  });
}
