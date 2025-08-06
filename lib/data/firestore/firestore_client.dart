abstract class FirestoreClient {
  Future<void> createTask({
    required String userId,
    required Map<String, dynamic> data,
  });
  Future<void> updateTask({
    required String userId,
    required String taskId,
    required Map<String, dynamic> data,
  });
  Future<void> deleteTask({required String userId, required String taskId});
  Future<List<Map<String, dynamic>>> loadTasks({required String userId});
}
