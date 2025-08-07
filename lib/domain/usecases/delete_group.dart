import 'package:fly_checklist/domain/entities/entities.dart';

abstract class DeleteGroup {
  Future<void> call({required String userId, required GroupEntity group});
}
