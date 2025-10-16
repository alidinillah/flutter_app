

import 'package:dio/dio.dart';
import 'package:flutter_app/modules/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> fetchProfile(int id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl(this.dio);

  @override
  Future<ProfileModel> fetchProfile(int id) async {
    final response = await dio.get('account/${478}');
    final Map<String, dynamic> jsonResponse = response.data;
    ProfileModel detailMovie = ProfileModel.fromJson(jsonResponse);
    return detailMovie;
  }
}
