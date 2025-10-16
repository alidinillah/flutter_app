
import 'package:flutter_app/modules/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile(int id);
}
