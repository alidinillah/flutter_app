import 'package:flutter_app/modules/home/domain/entities/genre.dart';

import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendingMovies();
  Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Genre>> getGenres();
}
