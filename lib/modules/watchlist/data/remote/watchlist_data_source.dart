import 'package:dio/dio.dart';

import '../models/watchlist_model.dart';


abstract class WatchlistRemoteDataSource {
  Future<WatchlistModel> getWatchlistMovies({required int accountId,
    required String sessionId,required int page});
  Future<WatchlistModel> getWatchlistTvShows({required int accountId,
    required String sessionId, required int page});
}

class WatchlistRemoteDataSourceImpl implements WatchlistRemoteDataSource {
  final Dio _dio;

  WatchlistRemoteDataSourceImpl(this._dio);

  @override
  Future<WatchlistModel> getWatchlistMovies({required int accountId,
    required String sessionId, required int page}) async {
    final response = await _dio.get(
      '/account/$accountId/watchlist/movies',
      queryParameters: {
        'session_id': sessionId,
        'page': page,
        'sort_by': 'created_at.desc',
      },
    );

    if (response.statusCode == 200) {
      return WatchlistModel.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: 'Failed to load watchlist movies',
      );
    }
  }

  @override
  Future<WatchlistModel> getWatchlistTvShows({required int accountId,
    required String sessionId, required int page}) async {
    final response = await _dio.get(
      '/account/$accountId/watchlist/tv',
      queryParameters: {
        'session_id': sessionId,
        'page': page,
        'sort_by': 'created_at.desc',
      },
    );

    if (response.statusCode == 200) {
      return WatchlistModel.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: 'Failed to load watchlist TV shows',
      );
    }
  }
}
