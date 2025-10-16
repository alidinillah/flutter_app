

import 'package:flutter_app/modules/home/data/models/movie_model.dart';


class WatchlistModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  WatchlistModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory WatchlistModel.fromJson(Map<String, dynamic> json) {
    return WatchlistModel(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((item) => MovieModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
