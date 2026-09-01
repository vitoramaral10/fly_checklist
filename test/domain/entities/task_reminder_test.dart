import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/domain/entities/entities.dart';

TaskEntity _makeTask({
  String id = 'any_task_id',
  String title = 'Comprar leite',
  String? groupId,
  DateTime? dueDate,
  bool isDone = false,
}) {
  return TaskEntity(
    id: id,
    groupId: groupId,
    title: title,
    description: '',
    dueDate: dueDate,
    priority: 2,
    isDone: isDone,
    createdAt: DateTime(2026, 1, 1),
  );
}

void main() {
  group('notificationIdFrom', () {
    test('Should be stable for the same task id', () {
      expect(
        TaskReminder.notificationIdFrom('abc123'),
        TaskReminder.notificationIdFrom('abc123'),
      );
    });

    test('Should differ for different task ids', () {
      expect(
        TaskReminder.notificationIdFrom('abc123'),
        isNot(TaskReminder.notificationIdFrom('abc124')),
      );
    });

    test('Should always fit in a positive 32 bit int', () {
      final ids = [
        '',
        'a',
        'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',
        'GgYh2kL9pQrStUvWxYz0',
        'çãé — acentos e símbolos',
      ];

      for (final id in ids) {
        final notificationId = TaskReminder.notificationIdFrom(id);

        expect(notificationId, greaterThanOrEqualTo(0));
        expect(notificationId, lessThanOrEqualTo(0x7FFFFFFF));
      }
    });
  });

  group('scheduledAtFor', () {
    test('Should schedule at the reminder hour of the due date', () {
      final scheduledAt = TaskReminder.scheduledAtFor(DateTime(2026, 5, 10));

      expect(scheduledAt, DateTime(2026, 5, 10, TaskReminder.reminderHour));
    });

    test('Should ignore any time already present in the due date', () {
      final scheduledAt = TaskReminder.scheduledAtFor(
        DateTime(2026, 5, 10, 23, 47),
      );

      expect(scheduledAt, DateTime(2026, 5, 10, TaskReminder.reminderHour));
    });
  });

  group('forTask', () {
    final now = DateTime(2026, 5, 1, 12);

    test('Should build a reminder for a future due date', () {
      final task = _makeTask(dueDate: DateTime(2026, 5, 10));

      final reminder = TaskReminder.forTask(task, now: now);

      expect(reminder, isNotNull);
      expect(reminder!.notificationId, TaskReminder.notificationIdFrom(task.id));
      expect(reminder.title, 'Comprar leite');
      expect(reminder.scheduledAt, DateTime(2026, 5, 10, 9));
    });

    test('Should mention the group in the body when there is one', () {
      final task = _makeTask(
        groupId: 'any_group_id',
        dueDate: DateTime(2026, 5, 10),
      );

      final reminder = TaskReminder.forTask(
        task,
        groupName: 'Pré-voo',
        now: now,
      );

      expect(reminder!.body, contains('Pré-voo'));
    });

    test('Should not mention a group when the name is blank', () {
      final task = _makeTask(dueDate: DateTime(2026, 5, 10));

      final reminder = TaskReminder.forTask(task, groupName: '   ', now: now);

      expect(reminder!.body, 'Vence hoje.');
    });

    test('Should return null when the task has no due date', () {
      final reminder = TaskReminder.forTask(_makeTask(), now: now);

      expect(reminder, isNull);
    });

    test('Should return null when the task is already done', () {
      final task = _makeTask(dueDate: DateTime(2026, 5, 10), isDone: true);

      expect(TaskReminder.forTask(task, now: now), isNull);
    });

    test('Should return null when the task has no id yet', () {
      final task = _makeTask(id: '', dueDate: DateTime(2026, 5, 10));

      expect(TaskReminder.forTask(task, now: now), isNull);
    });

    test('Should return null when the due date is in the past', () {
      final task = _makeTask(dueDate: DateTime(2026, 4, 20));

      expect(TaskReminder.forTask(task, now: now), isNull);
    });

    test(
      'Should return null when the task is due today but the hour has passed',
      () {
        final task = _makeTask(dueDate: DateTime(2026, 5, 1));

        expect(TaskReminder.forTask(task, now: now), isNull);
      },
    );

    test('Should build a reminder when the task is due later today', () {
      final task = _makeTask(dueDate: DateTime(2026, 5, 1));

      final reminder = TaskReminder.forTask(
        task,
        now: DateTime(2026, 5, 1, 6),
      );

      expect(reminder!.scheduledAt, DateTime(2026, 5, 1, 9));
    });
  });
}
