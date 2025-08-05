import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      // Ensure user is authenticated
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        log('User not authenticated', name: 'FirestoreAdapter.createTask');
        throw FirestoreError.unexpected;
      }

      // Verify the authenticated user matches the userId parameter
      if (currentUser.uid != userId) {
        log('User ID mismatch: ${currentUser.uid} != $userId', name: 'FirestoreAdapter.createTask');
        throw FirestoreError.unexpected;
      }

      await instance.collection('users').doc(userId).collection('tasks').add(data);
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'FirestoreAdapter.createTask');
      throw FirestoreError.unexpected;
    }
  }
}
