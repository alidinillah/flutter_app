import '../../../home/data/models/movie_model.dart';

class Watchlist {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  Watchlist({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
}