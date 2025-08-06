import 'dart:developer';

import 'package:fly_checklist/data/models/models.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firestore/firestore.dart';

class FirestoreCreateTask implements CreateTask {
  final FirestoreClient firestoreClient;

  FirestoreCreateTask({required this.firestoreClient});

  @override
  Future<void> call({required String userId, required TaskEntity task}) async {
    try {
      await firestoreClient.createTask(
        userId: userId,
        data: TaskModel.fromEntity(task).toJson(),
      );
    } on FirestoreError catch (e) {
      log(e.toString(), name: 'FirestoreCreateTask.call');
      throw DomainError.unexpected;
    }
  }
}
