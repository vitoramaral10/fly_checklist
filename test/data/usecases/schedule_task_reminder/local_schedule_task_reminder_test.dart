import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/data/notifications/notifications.dart';
import 'package:fly_checklist/data/usecases/usecases.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:fly_checklist/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';

class _NotificationClientSpy extends Mock implements NotificationClient {}

TaskEntity _makeTask({
  String id = 'any_task_id',
  DateTime? dueDate,
  bool isDone = false,
}) {
  return TaskEntity(
    id: id,
    title: 'Comprar leite',
    description: '',
    dueDate: dueDate,
    priority: 2,
    isDone: isDone,
    createdAt: DateTime(2026, 1, 1),
  );
}

void main() {
  late _NotificationClientSpy notificationClient;
  late LocalScheduleTaskReminder sut;

  /// Uma data suficientemente distante para que o lembrete nunca caia no
  /// passado enquanto a suíte roda.
  DateTime futureDueDate() => DateTime.now().add(const Duration(days: 30));

  setUp(() {
    notificationClient = _NotificationClientSpy();
    sut = LocalScheduleTaskReminder(notificationClient: notificationClient);

    when(
      () => notificationClient.schedule(
        id: any(named: 'id'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        scheduledAt: any(named: 'scheduledAt'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => notificationClient.cancel(id: any(named: 'id')),
    ).thenAnswer((_) async {});
  });

  test('Should schedule a task with a future due date', () async {
    final dueDate = futureDueDate();
    final task = _makeTask(dueDate: dueDate);

    await sut.call(task: task, groupName: 'Pré-voo');

    verify(
      () => notificationClient.schedule(
        id: TaskReminder.notificationIdFrom(task.id),
        title: 'Comprar leite',
        body: 'Vence hoje • Pré-voo',
        scheduledAt: TaskReminder.scheduledAtFor(dueDate),
      ),
    ).called(1);
    verifyNever(() => notificationClient.cancel(id: any(named: 'id')));
  });

  test('Should cancel when the task has no due date', () async {
    final task = _makeTask();

    await sut.call(task: task);

    verify(
      () => notificationClient.cancel(
        id: TaskReminder.notificationIdFrom(task.id),
      ),
    ).called(1);
    verifyNever(
      () => notificationClient.schedule(
        id: any(named: 'id'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        scheduledAt: any(named: 'scheduledAt'),
      ),
    );
  });

  test('Should cancel when the task is done', () async {
    final task = _makeTask(dueDate: futureDueDate(), isDone: true);

    await sut.call(task: task);

    verify(
      () => notificationClient.cancel(
        id: TaskReminder.notificationIdFrom(task.id),
      ),
    ).called(1);
  });

  test('Should cancel when the due date is already in the past', () async {
    final task = _makeTask(dueDate: DateTime(2020, 1, 1));

    await sut.call(task: task);

    verify(
      () => notificationClient.cancel(
        id: TaskReminder.notificationIdFrom(task.id),
      ),
    ).called(1);
  });

  test('Should do nothing when the task has no id yet', () async {
    await sut.call(task: _makeTask(id: '', dueDate: futureDueDate()));

    verifyZeroInteractions(notificationClient);
  });

  test(
    'Should throw DomainError.unexpected if NotificationClient throws',
    () async {
      when(
        () => notificationClient.schedule(
          id: any(named: 'id'),
          title: any(named: 'title'),
          body: any(named: 'body'),
          scheduledAt: any(named: 'scheduledAt'),
        ),
      ).thenThrow(NotificationError.unexpected);

      final future = sut.call(task: _makeTask(dueDate: futureDueDate()));

      await expectLater(future, throwsA(DomainError.unexpected));
    },
  );
}
