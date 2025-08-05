import 'dart:developer';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';

class FirestoreCreateTask implements CreateTask {
  final FirestoreClient firestoreClient;

  FirestoreCreateTask({required this.firestoreClient});

  @override
  Future<void> call({
    required String userId,
    required CreateTaskParams params,
  }) async {
    try {
      await firestoreClient.createTask(userId: userId, data: params.toJson());
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreCreateTask.call');
      throw DomainError.unexpected;
    }
  }
}
