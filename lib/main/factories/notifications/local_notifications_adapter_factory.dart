import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../infra/infra.dart';

/// Instância única do adapter.
///
/// Precisa ser compartilhada: é ela que guarda se o plugin já foi inicializado
/// e se a permissão de notificação já foi concedida.
LocalNotificationsAdapter? _adapter;

LocalNotificationsAdapter makeLocalNotificationsAdapter() =>
    _adapter ??= LocalNotificationsAdapter(
      plugin: FlutterLocalNotificationsPlugin(),
    );
