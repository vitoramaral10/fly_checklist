/// Fronteira do app com o serviço de notificações locais do sistema.
///
/// Fala em id, texto e instante — nada de canal, permissão ou fuso, que são
/// detalhes do adapter na camada de infra.
abstract class NotificationClient {
  /// Agenda (ou reagenda, quando o [id] já existe) uma notificação.
  ///
  /// [scheduledAt] é um horário local: quem implementa converte para o que o
  /// sistema espera.
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
  });

  Future<void> cancel({required int id});
}
