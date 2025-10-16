import 'package:flutter_app/modules/home/domain/entities/movie.dart';
import 'package:flutter_app/modules/watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlistMovies {
  final WatchlistRepository repository;

  GetWatchlistMovies(this.repository);

  Future<List<Movie>> call(int accountId, String sessionId, int page) {
    return repository.getWatchlistMovies(
      accountId: accountId,
      sessionId: sessionId,
      page: page,
    );
  }
}

class GetWatchlistTvShows {
  final WatchlistRepository repository;

  GetWatchlistTvShows(this.repository);

  Future<List<Movie>> call(
    int accountId,
    String sessionId,
    int page,
  ) {
    return repository.getWatchlistTvShows(
      accountId: accountId,
      sessionId: sessionId,
      page: page,
    );
  }
}
