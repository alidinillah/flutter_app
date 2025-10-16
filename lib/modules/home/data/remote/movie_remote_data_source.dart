import 'package:dio/dio.dart';
import 'package:flutter_app/modules/home/data/models/genre_model.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> fetchTrendingMovies();
  Future<List<MovieModel>> fetchNowPlayingMovies();
  Future<List<MovieModel>> fetchTopRatedMovies();
  Future<List<GenreModel>> fetchGenres();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MovieModel>> fetchTrendingMovies() async {
    final response = await dio.get('movie/popular');
    final List data = response.data['results'];
    return data.map((json) => MovieModel.fromJson(json)).toList();
  }

  @override
  Future<List<MovieModel>> fetchNowPlayingMovies() async {
    final response = await dio.get('movie/now_playing');
    final List data = response.data['results'];
    return data.map((json) => MovieModel.fromJson(json)).toList();
  }

  @override
  Future<List<MovieModel>> fetchTopRatedMovies() async {
    final response = await dio.get('movie/top_rated');
    final List data = response.data['results'];
    return data.map((json) => MovieModel.fromJson(json)).toList();
  }
  @override
  Future<List<GenreModel>> fetchGenres() async {
    final response = await dio.get('genre/movie/list');
    final List data = response.data['genres'];
    return data.map((json) => GenreModel.fromJson(json)).toList();
  }
}
