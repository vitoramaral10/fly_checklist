import 'dart:developer';

import 'package:fly_checklist/domain/entities/entities.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';

class FirestoreDeleteTask implements DeleteTask {
  final FirestoreClient firestoreClient;

  FirestoreDeleteTask({required this.firestoreClient});

  @override
  Future<void> call({required String userId, required TaskEntity task}) async {
    try {
      await firestoreClient.deleteTask(userId: userId, taskId: task.id);
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreDeleteTask.call');
      throw DomainError.unexpected;
    }
  }
}
