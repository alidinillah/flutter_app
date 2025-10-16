

import '../../domain/entities/profile.dart';

class ProfileModel {
  final int id;
  final String username;
  final String name;
  final String? avatarPath;

  ProfileModel({
    required this.id,
    required this.username,
    required this.name,
    this.avatarPath,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final avatar = json['avatar']?['tmdb']?['avatar_path'] ?? json['avatar']?['gravatar']?['hash'];

    return ProfileModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? 'N/A',
      name: json['name'] ?? '',
      avatarPath: avatar != null && avatar.toString().startsWith('/')
          ? 'https://image.tmdb.org/t/p/w500$avatar'
          : (avatar.toString().contains('http') ? avatar : null),
    );
  }

  Profile toEntity() {
    return Profile(
      id: id,
      username: username,
      name: name,
      avatarPath: avatarPath,
    );
  }
}
