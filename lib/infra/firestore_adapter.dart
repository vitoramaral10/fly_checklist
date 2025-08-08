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
      QuerySnapshot<Map<String, dynamic>> snapshot;
      if (groupId == null) {
        snapshot = await instance
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .where('groupId', isNull: true)
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
  }) {
    try {
      return instance
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
  }) {
    try {
      return instance
          .collection('users')
          .doc(userId)
          .collection('groups')
          .doc(groupId)
          .get()
          .then((doc) {
            if (doc.exists) {
              var data = doc.data();
              data!['id'] = doc.id;

              return data;
            } else {
              throw FirestoreError.notFound;
            }
          });
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.getGroup');
      throw FirestoreError.unexpected;
    }
  }
}
