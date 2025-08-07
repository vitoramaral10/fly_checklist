import '../entities/entities.dart';

abstract class LoadTasks {
  Future<List<TaskEntity>> call({required String userId, String? groupId});
}
