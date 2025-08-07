import 'package:fly_checklist/domain/entities/entities.dart';

abstract class UpdateGroup {
  Future<void> call({required String userId, required GroupEntity group});
}
