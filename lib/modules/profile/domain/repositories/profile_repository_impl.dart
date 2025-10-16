
import 'package:flutter_app/modules/profile/domain/entities/profile.dart';
import 'package:flutter_app/modules/profile/domain/repositories/profile_repository.dart';

import '../../data/remote/profile_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<Profile> getProfile(int id) async {
    final profile = await remote.fetchProfile(id);
    return profile.toEntity();
  }
}
