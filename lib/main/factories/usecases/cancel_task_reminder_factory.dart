import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

CancelTaskReminder makeLocalCancelTaskReminder() => LocalCancelTaskReminder(
  notificationClient: makeLocalNotificationsAdapter(),
);
