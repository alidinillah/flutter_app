import 'package:flutter_app/modules/home/domain/entities/movie.dart';

abstract class WatchlistRepository {
  Future<List<Movie>> getWatchlistMovies(
      {required int accountId, required String sessionId, required int page});
  Future<List<Movie>> getWatchlistTvShows(
      {required int accountId, required String sessionId, required int page});
}
