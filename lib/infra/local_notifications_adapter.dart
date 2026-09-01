import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../data/notifications/notifications.dart';

class LocalNotificationsAdapter implements NotificationClient {
  static const String channelId = 'task_due_reminders';
  static const String channelName = 'Lembretes de tarefas';
  static const String channelDescription =
      'Avisa no dia em que uma tarefa vence.';

  /// Ícone padrão da notificação.
  ///
  /// O guia oficial do Android pede um drawable monocromático; enquanto o
  /// projeto não tiver um, o launcher icon é o que existe e funciona.
  static const String defaultIcon = '@mipmap/ic_launcher';

  final FlutterLocalNotificationsPlugin plugin;

  LocalNotificationsAdapter({required this.plugin});

  bool _initialized = false;
  bool _permissionGranted = false;

  /// Prepara o plugin. Idempotente: pode ser chamada no boot do app e de novo
  /// antes de qualquer agendamento.
  ///
  /// Falhar aqui não é fatal — o app roda sem lembretes, e cada agendamento
  /// tenta inicializar de novo.
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings(defaultIcon),
        ),
      );
      _initialized = true;
    } catch (e) {
      log(e.toString(), name: 'LocalNotificationsAdapter.initialize');
    }
  }

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
  }) async {
    try {
      await initialize();

      // Sem permissão não há o que agendar, e insistir não é erro: o usuário
      // recusou, o resto do app segue igual.
      if (!await _ensurePermission()) return;

      await plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: _toTZDateTime(scheduledAt),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            channelName,
            channelDescription: channelDescription,
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
        ),
        // Inexato de propósito: um lembrete de checklist tolera alguns minutos
        // de atraso e, em troca, o app não precisa de SCHEDULE_EXACT_ALARM nem
        // do atrito de pedir alarme exato ao usuário.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (e) {
      log(e.toString(), name: 'LocalNotificationsAdapter.schedule');
      throw NotificationError.unexpected;
    }
  }

  @override
  Future<void> cancel({required int id}) async {
    try {
      await initialize();
      await plugin.cancel(id: id);
    } catch (e) {
      log(e.toString(), name: 'LocalNotificationsAdapter.cancel');
      throw NotificationError.unexpected;
    }
  }

  /// Converte o horário local para `TZDateTime` sem depender do banco de fusos.
  ///
  /// `scheduledAt` é um `DateTime` local, então o instante que ele representa
  /// já leva em conta as regras de horário de verão vigentes naquela data.
  /// Expressar esse mesmo instante em UTC preserva o momento e dispensa
  /// descobrir o nome IANA do fuso do aparelho (que exigiria mais um plugin).
  static tz.TZDateTime _toTZDateTime(DateTime scheduledAt) =>
      tz.TZDateTime.from(scheduledAt, tz.UTC);

  /// Garante a permissão de notificação, pedindo-a apenas quando o app
  /// realmente vai agendar algo.
  Future<bool> _ensurePermission() async {
    if (_permissionGranted) return true;

    final android = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    // Plataforma sem implementação Android específica (teste, desktop): não há
    // permissão a pedir.
    if (android == null) {
      _permissionGranted = true;
      return true;
    }

    if (await android.areNotificationsEnabled() ?? false) {
      _permissionGranted = true;
      return true;
    }

    _permissionGranted = await android.requestNotificationsPermission() ?? false;

    return _permissionGranted;
  }
}
