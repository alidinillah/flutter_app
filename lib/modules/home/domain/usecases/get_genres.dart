import 'package:flutter_app/modules/home/domain/entities/genre.dart';

import '../repositories/movie_repository.dart';

class GetGenres {
  final MovieRepository repository;
  GetGenres(this.repository);

  Future<List<Genre>> execute() => repository.getGenres();
}
