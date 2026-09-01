import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../notifications/notifications.dart';

class LocalCancelTaskReminder implements CancelTaskReminder {
  final NotificationClient notificationClient;

  LocalCancelTaskReminder({required this.notificationClient});

  @override
  Future<void> call({required String taskId}) async {
    if (taskId.isEmpty) return;

    try {
      await notificationClient.cancel(
        id: TaskReminder.notificationIdFrom(taskId),
      );
    } on NotificationError catch (e) {
      log(e.toString(), name: 'LocalCancelTaskReminder.call');
      throw DomainError.unexpected;
    }
  }
}
