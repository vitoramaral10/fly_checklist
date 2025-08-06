import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/firestore/firestore.dart';

class FirestoreAdapter implements FirestoreClient {
  final FirebaseFirestore instance;

  FirestoreAdapter({required this.instance});

  @override
  Future<void> createTask({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(data);
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.createTask');
      throw FirestoreError.unexpected;
    }
  }

  @override
  Future<void> updateTask({
    required String userId,
    required String taskId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update(data);
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.updateTask');
      throw FirestoreError.unexpected;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> loadTasks({required String userId}) async {
    try {
      final snapshot = await instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.loadTasks');
      throw FirestoreError.unexpected;
    }
  }
}
