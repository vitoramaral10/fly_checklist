import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';
import '../../models/models.dart';

class FirestoreResetGroupTasks implements ResetGroupTasks {
  final FirestoreClient firestoreClient;

  FirestoreResetGroupTasks({required this.firestoreClient});

  @override
  Future<GroupEntity> call({
    required String userId,
    required GroupEntity group,
  }) async {
    try {
      // As tarefas são desmarcadas antes de o grupo registrar o reset: se algo
      // falhar no meio, `lastResetAt` continua antigo e o reset é tentado de
      // novo na próxima abertura, em vez de dar o dia por reiniciado.
      await firestoreClient.resetTasksByGroupId(
        userId: userId,
        groupId: group.id,
      );

      final resetGroup = group.copyWith(lastResetAt: DateTime.now());

      await firestoreClient.updateGroup(
        userId: userId,
        groupId: resetGroup.id,
        data: GroupModel.fromEntity(resetGroup).toJson(),
      );

      return resetGroup;
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreResetGroupTasks.call');
      throw DomainError.unexpected;
    }
  }
}
