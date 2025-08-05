class UserEntity {
  final String name;
  final String email;
  final String? photoUrl;
  final bool emailVerified;

  UserEntity({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.emailVerified,
  });
}
