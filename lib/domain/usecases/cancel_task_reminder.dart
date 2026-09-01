/// Cancela o lembrete local de uma tarefa que deixou de existir.
///
/// Recebe o id em vez da entidade porque é usado justamente quando a tarefa
/// some do repositório e só o id ainda faz sentido.
abstract class CancelTaskReminder {
  Future<void> call({required String taskId});
}
