import 'dart:developer';

import 'package:fly_checklist/domain/entities/entities.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';
import '../../models/models.dart';

class FirestoreUpdateTask implements UpdateTask {
  final FirestoreClient firestoreClient;

  FirestoreUpdateTask({required this.firestoreClient});

  @override
  Future<void> call({required String userId, required TaskEntity task}) async {
    try {
      await firestoreClient.updateTask(
        userId: userId,
        taskId: task.id,
        data: TaskModel.fromEntity(task).toJson(),
      );
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreUpdateTask.call');
      throw DomainError.unexpected;
    }
  }
}
