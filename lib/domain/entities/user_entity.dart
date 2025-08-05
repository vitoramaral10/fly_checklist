class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final bool emailVerified;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.emailVerified,
  });
}
