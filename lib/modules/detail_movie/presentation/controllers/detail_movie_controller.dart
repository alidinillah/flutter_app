import 'package:flutter/cupertino.dart';
import 'package:flutter_app/modules/detail_movie/domain/entities/review.dart';
import 'package:flutter_app/modules/detail_movie/domain/usecases/get_detail_movie.dart';
import 'package:flutter_app/modules/detail_movie/domain/usecases/get_review.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/detail_movie.dart';


class DetailMovieController extends GetxController {
  late int id;
  final GetDetailMovie getDetailMovie;
  final GetReview getReview;

  DetailMovieController({
    required this.getDetailMovie,
    required this.getReview,
  });

  DetailMovie? detailMovie;
  var review = <Review>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is int) {
      id = Get.arguments as int;
      fetchDetailMovie();
    } else {
      Get.back();
    }
  }

  Future<void> fetchDetailMovie() async {
    isLoading.value = true;
    detailMovie = await getDetailMovie(id);
    review.value = await getReview(id);
    isLoading.value = false;
  }

  Future<void> refreshDetailMovie() async {
    await fetchDetailMovie();
  }

  String formatCurrency(int amount) {
    if (amount == 0) return '-';
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  String formatRuntime(int minutes) {
    if (minutes == 0) return '-';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}m';
  }

  String formatReleaseDate(String dateString) {
    if (dateString.isEmpty) return '-';
    try {
      DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);
      DateFormat formatter = DateFormat('MMM dd, yyyy');
      return formatter.format(dateTime);
    } catch (e) {
      debugPrint('Error parsing date: $dateString, $e');
      return dateString;
    }
  }
}
