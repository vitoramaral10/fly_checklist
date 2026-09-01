import '../entities/entities.dart';

/// Sincroniza o lembrete local da tarefa com o estado atual dela.
///
/// É idempotente e serve tanto para agendar quanto para desagendar: tarefa que
/// não deve mais notificar (sem data, concluída ou já vencida) tem o lembrete
/// cancelado pela mesma chamada. Assim o chamador não precisa repetir a regra
/// de "quando notificar" em cada fluxo.
abstract class ScheduleTaskReminder {
  Future<void> call({required TaskEntity task, String? groupName});
}
