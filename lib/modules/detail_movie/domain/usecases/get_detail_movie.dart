import 'package:flutter_app/modules/detail_movie/domain/entities/detail_movie.dart';
import 'package:flutter_app/modules/detail_movie/domain/repositories/detail_movie_repository.dart';

class GetDetailMovie {
  final DetailMovieRepository repository;

  GetDetailMovie(this.repository);

  Future<DetailMovie> call(int id) {
    return repository.getDetailMovie(id);
  }
}
