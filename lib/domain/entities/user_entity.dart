class UserEntity {
  final String name;
  final String? photoUrl;
  final bool emailVerified;

  UserEntity({
    required this.name,
    required this.photoUrl,
    required this.emailVerified,
  });
}
