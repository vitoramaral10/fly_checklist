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
      await firestoreClient.deleteGroup(userId: userId, groupId: group.id);
      await firestoreClient.deleteTasksByGroupId(
        userId: userId,
        groupId: group.id,
      );
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreDeleteGroup.call');
      throw DomainError.unexpected;
    }
  }
}
