abstract class FirestoreClient {
  Future<List<Map<String, dynamic>>> loadTasks({
    required String userId,
    String? groupId,
  });
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

  Future<List<Map<String, dynamic>>> loadGroups({required String userId});
  Future<void> createGroup({
    required String userId,
    required Map<String, dynamic> data,
  });
  Future<void> updateGroup({
    required String userId,
    required String groupId,
    required Map<String, dynamic> data,
  });
  Future<void> deleteGroup({required String userId, required String groupId});
  Future<void> deleteTasksByGroupId({
    required String userId,
    required String groupId,
  });
}
