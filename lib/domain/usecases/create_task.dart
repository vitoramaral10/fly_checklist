import 'package:fly_checklist/domain/entities/entities.dart';

abstract class CreateTask {
  Future<void> call({required String userId, required TaskEntity task});
}
