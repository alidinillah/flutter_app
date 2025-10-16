import 'package:flutter_app/modules/detail_movie/domain/entities/detail_movie.dart';
import 'package:flutter_app/modules/detail_movie/domain/entities/review.dart';

abstract class DetailMovieRepository {
  Future<DetailMovie> getDetailMovie(int id);
  Future<List<Review>> getReview(int id);
}
