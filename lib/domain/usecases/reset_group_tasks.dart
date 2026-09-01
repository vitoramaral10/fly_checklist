import '../entities/entities.dart';

/// Reinicia o checklist de um grupo: desmarca todas as tarefas dele e registra
/// o momento do reset no próprio grupo.
///
/// Devolve o grupo já com o novo `lastResetAt`, para que quem chamou não
/// precise reler o documento só para saber que o reset do dia já aconteceu.
abstract class ResetGroupTasks {
  Future<GroupEntity> call({
    required String userId,
    required GroupEntity group,
  });
}
