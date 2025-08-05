abstract class FirestoreClient {
  Future<void> createTask({
    required String userId,
    required Map<String, dynamic> data,
  });
}
