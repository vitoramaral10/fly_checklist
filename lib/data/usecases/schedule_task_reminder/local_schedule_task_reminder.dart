import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../notifications/notifications.dart';

class LocalScheduleTaskReminder implements ScheduleTaskReminder {
  final NotificationClient notificationClient;

  LocalScheduleTaskReminder({required this.notificationClient});

  @override
  Future<void> call({required TaskEntity task, String? groupName}) async {
    // Tarefa ainda sem id não tem chave de agendamento; nada a fazer, nem
    // sequer cancelar.
    if (task.id.isEmpty) return;

    final notificationId = TaskReminder.notificationIdFrom(task.id);
    final reminder = TaskReminder.forTask(task, groupName: groupName);

    try {
      if (reminder == null) {
        // A tarefa deixou de ser notificável: derruba o que houver agendado.
        await notificationClient.cancel(id: notificationId);
        return;
      }

      await notificationClient.schedule(
        id: reminder.notificationId,
        title: reminder.title,
        body: reminder.body,
        scheduledAt: reminder.scheduledAt,
      );
    } on NotificationError catch (e) {
      log(e.toString(), name: 'LocalScheduleTaskReminder.call');
      throw DomainError.unexpected;
    }
  }
}
