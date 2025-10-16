import 'package:flutter_app/modules/detail_movie/domain/entities/detail_movie.dart';
import 'package:flutter_app/modules/detail_movie/domain/entities/review.dart';

import '../../data/remote/detail_movie_data_source.dart';
import 'detail_movie_repository.dart';

class DetailMovieRepositoryImpl implements DetailMovieRepository {
  final DetailMovieRemoteDataSource remote;

  DetailMovieRepositoryImpl(this.remote);

  @override
  Future<DetailMovie> getDetailMovie(int id) async {
    final detailMovie = await remote.fetchDetailMovie(id);
    return detailMovie.toEntity();
  }

  @override
  Future<List<Review>> getReview(int id) async {
    final models = await remote.fetchReview(id);
    return models
        .map((m) => Review(
              author: m.author,
              content: m.content,
              rating: m.rating,
              avatarPath: m.avatarPath,
              createdAt: m.createdAt,
            ))
        .toList();
  }
}
