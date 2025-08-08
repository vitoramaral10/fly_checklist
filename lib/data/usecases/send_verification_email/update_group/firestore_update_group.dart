import 'dart:developer';

import 'package:fly_checklist/domain/entities/entities.dart';

import '../../../../domain/helpers/helpers.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../firestore/firestore.dart';
import '../../../models/models.dart';

class FirestoreUpdateGroup implements UpdateGroup {
  final FirestoreClient firestoreClient;

  FirestoreUpdateGroup({required this.firestoreClient});

  @override
  Future<void> call({
    required String userId,
    required GroupEntity group,
  }) async {
    try {
      await firestoreClient.updateGroup(
        userId: userId,
        groupId: group.id,
        data: GroupModel.fromEntity(group).toJson(),
      );
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreUpdateGroup.call');
      throw DomainError.unexpected;
    }
  }
}
