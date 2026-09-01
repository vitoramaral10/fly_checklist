import '../entities/entities.dart';

abstract class LoadTasks {
  /// Carrega as tarefas de um grupo quando [groupId] é informado; sem ele,
  /// carrega todas as tarefas do usuário, inclusive as que estão em grupos.
  Future<List<TaskEntity>> call({required String userId, String? groupId});
}
