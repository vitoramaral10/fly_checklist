import '../../domain/entities/entities.dart';

class UserModel {
  final String name;
  final String? photoUrl;
  final bool emailVerified;

  UserModel({
    required this.name,
    required this.photoUrl,
    required this.emailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['displayName'],
      photoUrl: json['photoURL'],
      emailVerified: json['emailVerified'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      name: name,
      photoUrl: photoUrl,
      emailVerified: emailVerified,
    );
  }
}
