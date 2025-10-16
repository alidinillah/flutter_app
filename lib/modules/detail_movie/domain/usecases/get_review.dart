import 'package:flutter_app/modules/detail_movie/domain/entities/review.dart';
import 'package:flutter_app/modules/detail_movie/domain/repositories/detail_movie_repository.dart';


class GetReview {
  final DetailMovieRepository repository;
  GetReview(this.repository);

  Future<List<Review>> call(int id) {
    return repository.getReview(id);
  }
}
