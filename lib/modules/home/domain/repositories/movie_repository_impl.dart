import 'package:flutter_app/modules/home/domain/entities/genre.dart';

import '../../data/remote/movie_remote_data_source.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;

  MovieRepositoryImpl(this.remote);

  @override
  Future<List<Movie>> getTrendingMovies() async {
    final models = await remote.fetchTrendingMovies();
    return models
        .map((m) => Movie(
      id: m.id,
      originalTitle: m.originalTitle,
      overview: m.overview,
      posterPath: m.posterPath,
      voteAverage: m.voteAverage,
      releaseDate: m.releaseDate,
    ))
        .toList();
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    final models = await remote.fetchNowPlayingMovies();
    return models
        .map((m) => Movie(
      id: m.id,
      originalTitle: m.originalTitle,
      overview: m.overview,
      posterPath: m.posterPath,
      voteAverage: m.voteAverage,
      releaseDate: m.releaseDate,
    ))
        .toList();
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    final models = await remote.fetchNowPlayingMovies();
    return models
        .map((m) => Movie(
      id: m.id,
      originalTitle: m.originalTitle,
      overview: m.overview,
      posterPath: m.posterPath,
      voteAverage: m.voteAverage,
      releaseDate: m.releaseDate,
    ))
        .toList();
  }

  @override
  Future<List<Genre>> getGenres() async {
    final models = await remote.fetchGenres();
    return models
        .map((e) => Genre(
      id: e.id,
      name: e.name,
    ))
        .toList();
  }
}
