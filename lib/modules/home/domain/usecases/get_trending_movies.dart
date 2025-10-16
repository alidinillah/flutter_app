import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository repository;
  GetTrendingMovies(this.repository);

  Future<List<Movie>> execute() => repository.getTrendingMovies();
}
