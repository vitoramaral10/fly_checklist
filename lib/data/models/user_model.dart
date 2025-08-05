import '../../domain/entities/entities.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final bool emailVerified;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.emailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['displayName'],
      email: json['email'],
      photoUrl: json['photoURL'],
      emailVerified: json['emailVerified'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      name: name,
      email: email,
      photoUrl: photoUrl,
      emailVerified: emailVerified,
    );
  }
}
