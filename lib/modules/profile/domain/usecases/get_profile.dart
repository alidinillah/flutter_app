
import 'package:flutter_app/modules/profile/domain/entities/profile.dart';
import 'package:flutter_app/modules/profile/domain/repositories/profile_repository.dart';

class GetProfile{
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Profile> call(int id) {
    return repository.getProfile(id);
  }
}
