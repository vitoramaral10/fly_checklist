import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/firestore/firestore.dart';

class FirestoreAdapter implements FirestoreClient {
  final FirebaseFirestore instance;

  FirestoreAdapter({required this.instance});

  @override
  Future<String> createTask({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final document = await instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(data);

      return document.id;
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
  Future<void> deleteTask({
    required String userId,
    required String taskId,
  }) async {
    try {
      await instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.deleteTask');
      throw FirestoreError.unexpected;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> loadTasks({
    required String userId,
    String? groupId,
  }) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot;
      if (groupId == null) {
        snapshot = await instance
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .get();
      } else {
        snapshot = await instance
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .where('groupId', isEqualTo: groupId)
            .get();
      }

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

  @override
  Future<void> createGroup({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await instance
          .collection('users')
          .doc(userId)
          .collection('groups')
          .add(data);
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.createGroup');
      throw FirestoreError.unexpected;
    }
  }

  @override
  Future<void> deleteGroup({
    required String userId,
    required String groupId,
  }) async {
    try {
      await instance
          .collection('users')
          .doc(userId)
          .collection('groups')
          .doc(groupId)
          .delete();
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.deleteGroup');
      throw FirestoreError.unexpected;
    }
  }

  @override
  Future<void> deleteTasksByGroupId({
    required String userId,
    required String groupId,
  }) {
    // Usa WriteBatch e fraciona em blocos de até 500 operações, conforme limite do Firestore.
    return instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('groupId', isEqualTo: groupId)
        .get()
        .then((snapshot) async {
          final docs = snapshot.docs;
          if (docs.isEmpty) return;

          const int batchLimit = 500; // Limite de writes por batch no Firestore
          for (int i = 0; i < docs.length; i += batchLimit) {
            final end = (i + batchLimit < docs.length)
                ? i + batchLimit
                : docs.length;
            final batch = instance.batch();
            for (int j = i; j < end; j++) {
              batch.delete(docs[j].reference);
            }
            await batch.commit();
          }
        })
        .catchError((error) {
          log(error.toString(), name: 'FirestoreAdapter.deleteTasksByGroupId');
          throw FirestoreError.unexpected;
        });
  }

  @override
  Future<void> resetTasksByGroupId({
    required String userId,
    required String groupId,
  }) async {
    try {
      final snapshot = await instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .where('groupId', isEqualTo: groupId)
          .get();

      // O filtro por `isDone` fica em memória de propósito: uma consulta com
      // duas igualdades funcionaria, mas assim não dependemos de índice e
      // ainda escrevemos só nas tarefas que estão marcadas.
      final docs = snapshot.docs
          .where((doc) => doc.data()['isDone'] == true)
          .toList();
      if (docs.isEmpty) return;

      const int batchLimit = 500; // Limite de writes por batch no Firestore
      for (int i = 0; i < docs.length; i += batchLimit) {
        final end = (i + batchLimit < docs.length)
            ? i + batchLimit
            : docs.length;
        final batch = instance.batch();
        for (int j = i; j < end; j++) {
          batch.update(docs[j].reference, {'isDone': false});
        }
        await batch.commit();
      }
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.resetTasksByGroupId');
      throw FirestoreError.unexpected;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> loadGroups({
    required String userId,
  }) async {
    try {
      final snapshot = await instance
          .collection('users')
          .doc(userId)
          .collection('groups')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.loadGroups');
      throw FirestoreError.unexpected;
    }
  }

  @override
  Future<void> updateGroup({
    required String userId,
    required String groupId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await instance
          .collection('users')
          .doc(userId)
          .collection('groups')
          .doc(groupId)
          .update(data);
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.updateGroup');
      throw FirestoreError.unexpected;
    }
  }

  @override
  Future<Map<String, dynamic>> getGroup({
    required String userId,
    required String groupId,
  }) async {
    try {
      final doc = await instance
          .collection('users')
          .doc(userId)
          .collection('groups')
          .doc(groupId)
          .get();

      final data = doc.data();

      if (!doc.exists || data == null) {
        throw FirestoreError.notFound;
      }

      data['id'] = doc.id;

      return data;
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.getGroup');
      throw FirestoreError.unexpected;
    }
  }
}
