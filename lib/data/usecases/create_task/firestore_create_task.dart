import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';
import '../../models/models.dart';

class FirestoreCreateTask implements CreateTask {
  final FirestoreClient firestoreClient;

  FirestoreCreateTask({required this.firestoreClient});

  @override
  Future<String> call({
    required String userId,
    required TaskEntity task,
  }) async {
    try {
      return await firestoreClient.createTask(
        userId: userId,
        data: TaskModel.fromEntity(task).toJson(),
      );
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreCreateTask.call');
      throw DomainError.unexpected;
    }
  }
}
