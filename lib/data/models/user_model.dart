import '../../domain/entities/entities.dart';

class UserModel {
  final bool emailVerified;

  UserModel({required this.emailVerified});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(emailVerified: json['emailVerified'] ?? false);
  }

  UserEntity toEntity() {
    return UserEntity(emailVerified: emailVerified);
  }
}
