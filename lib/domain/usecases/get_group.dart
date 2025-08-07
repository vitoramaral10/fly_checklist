import '../entities/entities.dart';

abstract class GetGroup {
  Future<GroupEntity> call({required String userId, required String groupId});
}
