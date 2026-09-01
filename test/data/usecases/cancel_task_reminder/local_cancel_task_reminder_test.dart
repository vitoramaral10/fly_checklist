import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/data/notifications/notifications.dart';
import 'package:fly_checklist/data/usecases/usecases.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:fly_checklist/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';

class _NotificationClientSpy extends Mock implements NotificationClient {}

void main() {
  late _NotificationClientSpy notificationClient;
  late LocalCancelTaskReminder sut;

  setUp(() {
    notificationClient = _NotificationClientSpy();
    sut = LocalCancelTaskReminder(notificationClient: notificationClient);

    when(
      () => notificationClient.cancel(id: any(named: 'id')),
    ).thenAnswer((_) async {});
  });

  test('Should cancel the notification keyed by the task id', () async {
    await sut.call(taskId: 'any_task_id');

    verify(
      () => notificationClient.cancel(
        id: TaskReminder.notificationIdFrom('any_task_id'),
      ),
    ).called(1);
  });

  test('Should do nothing when the task id is empty', () async {
    await sut.call(taskId: '');

    verifyZeroInteractions(notificationClient);
  });

  test(
    'Should throw DomainError.unexpected if NotificationClient throws',
    () async {
      when(
        () => notificationClient.cancel(id: any(named: 'id')),
      ).thenThrow(NotificationError.unexpected);

      final future = sut.call(taskId: 'any_task_id');

      await expectLater(future, throwsA(DomainError.unexpected));
    },
  );
}
