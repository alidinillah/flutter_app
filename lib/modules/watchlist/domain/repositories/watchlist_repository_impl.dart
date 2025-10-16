import 'package:flutter_app/modules/home/domain/entities/movie.dart';
import 'package:flutter_app/modules/watchlist/domain/repositories/watchlist_repository.dart';

import '../../data/remote/watchlist_data_source.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource remoteDataSource;

  WatchlistRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getWatchlistMovies({
    required int accountId,
    required String sessionId,
    required int page,
  }) async {
    final result = await remoteDataSource.getWatchlistMovies(
      accountId: accountId,
      sessionId: sessionId,
      page: page,
    );
    return result.results.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getWatchlistTvShows({
    required int accountId,
    required String sessionId,
    required int page,
  }) async {
    final response = await remoteDataSource.getWatchlistTvShows(
      accountId: accountId,
      sessionId: sessionId,
      page: page,
    );
    return response.results.map((model) => model.toEntity()).toList();
  }
}
