import '../entities/entities.dart';

abstract class GetUser {
  Future<UserEntity> call();
}
