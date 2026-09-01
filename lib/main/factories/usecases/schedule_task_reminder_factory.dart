import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

ScheduleTaskReminder makeLocalScheduleTaskReminder() =>
    LocalScheduleTaskReminder(
      notificationClient: makeLocalNotificationsAdapter(),
    );
