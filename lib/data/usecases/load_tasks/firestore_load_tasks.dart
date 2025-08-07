import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';
import '../../models/models.dart';

class FirestoreLoadTasks implements LoadTasks {
  final FirestoreClient firestoreClient;

  FirestoreLoadTasks({required this.firestoreClient});

  @override
  Future<List<TaskEntity>> call({
    required String userId,
    String? groupId,
  }) async {
    try {
      final result = await firestoreClient.loadTasks(
        userId: userId,
        groupId: groupId,
      );
      return result.map((data) => TaskModel.fromJson(data).toEntity()).toList();
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreLoadTasks.call');
      throw DomainError.unexpected;
    }
  }
}
