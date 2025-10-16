class Profile {
  final int id;
  final String username;
  final String name;
  final String? avatarPath;

  Profile({
    required this.id,
    required this.username,
    required this.name,
    this.avatarPath,
  });
}
