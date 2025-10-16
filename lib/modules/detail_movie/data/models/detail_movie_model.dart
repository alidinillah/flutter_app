import 'package:flutter_app/modules/home/data/models/genre_model.dart';

import '../../domain/entities/detail_movie.dart';

class DetailMovieModel {
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
  final String title;
  final double voteAverage;
  final int voteCount;

  DetailMovieModel({
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
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory DetailMovieModel.fromJson(Map<String, dynamic> json) {
    var genresList = json['genres'] as List;
    List<GenreModel> genres =
        genresList.map((i) => GenreModel.fromJson(i)).toList();

    return DetailMovieModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      budget: json['budget'] ?? 0,
      genres: genres,
      homepage: json['homepage'] ?? '',
      id: json['id'],
      imdbId: json['imdb_id'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      releaseDate: json['release_date'] ?? '',
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      title: json['title'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
    );
  }

  DetailMovie toEntity() {
    return DetailMovie(
      adult: adult,
      backdropPath: backdropPath,
      budget: budget,
      genres: genres,
      homepage: homepage,
      id: id,
      imdbId: imdbId,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      revenue: revenue,
      runtime: runtime,
      status: status,
      tagline: tagline,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
