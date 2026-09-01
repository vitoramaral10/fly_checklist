import 'task_entity.dart';

/// Lembrete local de vencimento de uma tarefa.
///
/// Concentra a política de "quando e o que notificar" num objeto puro, sem
/// nenhuma dependência de plugin: quem agenda só precisa dos campos prontos.
class TaskReminder {
  /// Hora local em que o lembrete toca no dia do vencimento.
  ///
  /// `dueDate` guarda apenas a data, então o horário é uma decisão do app.
  /// 09:00 é cedo o bastante para dar margem ao dia e tarde o bastante para
  /// não acordar ninguém.
  static const int reminderHour = 9;

  /// Id da notificação no sistema operacional.
  ///
  /// Derivado do id da tarefa, para que reagendar sobrescreva o lembrete
  /// anterior em vez de duplicá-lo.
  final int notificationId;

  final String title;
  final String body;

  /// Instante local em que a notificação deve aparecer.
  final DateTime scheduledAt;

  const TaskReminder({
    required this.notificationId,
    required this.title,
    required this.body,
    required this.scheduledAt,
  });

  /// Id estável e positivo para o [taskId], no intervalo aceito por um `int`
  /// do Android.
  ///
  /// Usa FNV-1a de 32 bits em vez de `String.hashCode` porque o hash do Dart
  /// não tem estabilidade garantida entre execuções ou versões da linguagem —
  /// e um id que muda deixa o lembrete antigo órfão, impossível de cancelar.
  static int notificationIdFrom(String taskId) {
    var hash = 0x811c9dc5;
    for (final unit in taskId.codeUnits) {
      hash ^= unit & 0xFF;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash & 0x7FFFFFFF;
  }

  /// Momento do lembrete para um vencimento: [reminderHour] do próprio dia.
  static DateTime scheduledAtFor(DateTime dueDate) =>
      DateTime(dueDate.year, dueDate.month, dueDate.day, reminderHour);

  /// Lembrete da [task], ou `null` quando ela não deve ter nenhum agendado.
  ///
  /// Não rende lembrete a tarefa sem data, a concluída, a que ainda não tem id
  /// (não daria para cancelar depois) e a cujo horário já passou — inclusive
  /// quando vence hoje mas já passou das [reminderHour].
  ///
  /// [now] existe para os testes; em produção usa o relógio local, o mesmo em
  /// que o usuário lê a data de vencimento.
  static TaskReminder? forTask(
    TaskEntity task, {
    String? groupName,
    DateTime? now,
  }) {
    final dueDate = task.dueDate;

    if (task.id.isEmpty || task.isDone || dueDate == null) return null;

    final scheduledAt = scheduledAtFor(dueDate);

    if (!scheduledAt.isAfter(now ?? DateTime.now())) return null;

    return TaskReminder(
      notificationId: notificationIdFrom(task.id),
      title: task.title,
      body: _bodyFor(groupName),
      scheduledAt: scheduledAt,
    );
  }

  static String _bodyFor(String? groupName) {
    final name = groupName?.trim();

    return (name == null || name.isEmpty)
        ? 'Vence hoje.'
        : 'Vence hoje • $name';
  }
}
