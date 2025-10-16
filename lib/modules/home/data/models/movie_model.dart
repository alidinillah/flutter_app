import 'package:flutter_app/modules/home/domain/entities/movie.dart';

class MovieModel {
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;

  MovieModel({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
    );
  }

  Movie toEntity() {
    return Movie(
        id: id,
        originalTitle: originalTitle,
        overview: overview,
        posterPath: posterPath,
        voteAverage: voteAverage,
        releaseDate: releaseDate);
  }
}
