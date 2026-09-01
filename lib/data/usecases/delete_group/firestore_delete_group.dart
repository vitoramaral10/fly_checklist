import 'dart:developer';

import 'package:fly_checklist/domain/entities/entities.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';

class FirestoreDeleteGroup implements DeleteGroup {
  final FirestoreClient firestoreClient;

  FirestoreDeleteGroup({required this.firestoreClient});

  @override
  Future<void> call({
    required String userId,
    required GroupEntity group,
  }) async {
    try {
      // As tarefas são removidas antes do grupo: se a exclusão falhar no meio,
      // o grupo continua existindo e a operação pode ser repetida sem deixar
      // tarefas órfãs.
      await firestoreClient.deleteTasksByGroupId(
        userId: userId,
        groupId: group.id,
      );
      await firestoreClient.deleteGroup(userId: userId, groupId: group.id);
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreDeleteGroup.call');
      throw DomainError.unexpected;
    }
  }
}
