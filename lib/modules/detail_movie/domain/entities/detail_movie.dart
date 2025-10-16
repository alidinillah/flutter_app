import 'package:flutter_app/modules/home/data/models/genre_model.dart';

class DetailMovie {
  final bool adult;
  final String? backdropPath;
  final int budget;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;

  DetailMovie({
    required this.adult,
    this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });
}
