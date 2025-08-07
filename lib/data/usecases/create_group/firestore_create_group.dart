import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';
import '../../models/models.dart';

class FirestoreCreateGroup implements CreateGroup {
  final FirestoreClient firestoreClient;

  FirestoreCreateGroup({required this.firestoreClient});

  @override
  Future<void> call({
    required String userId,
    required GroupEntity group,
  }) async {
    try {
      await firestoreClient.createGroup(
        userId: userId,
        data: GroupModel.fromEntity(group).toJson(),
      );
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreCreateGroup.call');
      throw DomainError.unexpected;
    }
  }
}
