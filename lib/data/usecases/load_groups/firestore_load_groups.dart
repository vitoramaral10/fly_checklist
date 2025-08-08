import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';
import '../../models/models.dart';

class FirestoreLoadGroups implements LoadGroups {
  final FirestoreClient firestoreClient;

  FirestoreLoadGroups({required this.firestoreClient});

  @override
  Future<List<GroupEntity>> call(String userId) async {
    try {
      final result = await firestoreClient.loadGroups(userId: userId);
      return result
          .map((data) => GroupModel.fromJson(data).toEntity())
          .toList();
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreLoadGroups.call');
      throw DomainError.unexpected;
    }
  }
}
