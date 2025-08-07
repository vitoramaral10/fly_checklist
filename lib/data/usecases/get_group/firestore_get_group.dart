import 'dart:developer';

import 'package:fly_checklist/domain/entities/entities.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';
import '../../models/models.dart';

class FirestoreGetGroup implements GetGroup {
  final FirestoreClient firestoreClient;

  FirestoreGetGroup({required this.firestoreClient});

  @override
  Future<GroupEntity> call({
    required String userId,
    required String groupId,
  }) async {
    try {
      final groupData = await firestoreClient.getGroup(
        userId: userId,
        groupId: groupId,
      );
      return GroupModel.fromJson(groupData).toEntity();
    } catch (e) {
      log(e.toString(), name: 'FirestoreGetGroup.call');
      throw DomainError.unexpected;
    }
  }
}
