import 'package:fly_checklist/domain/entities/entities.dart';

abstract class CreateTask {
  /// Devolve o id atribuido a tarefa criada, chave do lembrete local.
  Future<String> call({required String userId, required TaskEntity task});
}
