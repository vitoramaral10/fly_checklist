import '../entities/entities.dart';

abstract class LoadGroups {
  Future<List<GroupEntity>> call(String userId);
}
