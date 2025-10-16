

import 'package:dio/dio.dart';
import 'package:flutter_app/modules/detail_movie/data/models/review_model.dart';
import '../models/detail_movie_model.dart';

abstract class DetailMovieRemoteDataSource {
  Future<DetailMovieModel> fetchDetailMovie(int id);
  Future<List<ReviewModel>> fetchReview(int id);
}

class DetailMovieRemoteDataSourceImpl implements DetailMovieRemoteDataSource {
  final Dio dio;

  DetailMovieRemoteDataSourceImpl(this.dio);

  @override
  Future<DetailMovieModel> fetchDetailMovie(int id) async {
    final response = await dio.get('movie/$id');
    final Map<String, dynamic> jsonResponse = response.data;
    DetailMovieModel detailMovie = DetailMovieModel.fromJson(jsonResponse);
    return detailMovie;
  }


  @override
  Future<List<ReviewModel>> fetchReview(int id) async {
    final response = await dio.get('movie/$id/reviews');
    final List data = response.data['results'];
    return data.map((json) => ReviewModel.fromJson(json)).toList();
  }
}
