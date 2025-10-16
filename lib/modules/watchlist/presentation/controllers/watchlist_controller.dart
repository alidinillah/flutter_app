import 'package:dio/dio.dart';
import 'package:flutter_app/core/widgets/type_chip.dart';
import 'package:flutter_app/modules/home/domain/entities/movie.dart';
import 'package:flutter_app/modules/watchlist/domain/usecases/get_watchlist.dart';
import 'package:get/get.dart';

class WatchlistController extends GetxController {

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTvShows getWatchlistTvShows;

  WatchlistController({
    required this.getWatchlistMovies,
    required this.getWatchlistTvShows,
  });

  final Rx<TypeEnum> selectedType = TypeEnum.all.obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxList<Movie> watchlistItems = <Movie>[].obs;

  @override
  void onInit() {
    fetchWatchlist(TypeEnum.all);
    super.onInit();
  }

  void selectType(TypeEnum type) {
    if (selectedType.value != type) {
      selectedType.value = type;
      fetchWatchlist(type);
    }
  }

  Future<void> fetchWatchlist(TypeEnum type) async {
    isLoading.value = true;
    errorMessage.value = '';
    watchlistItems.clear();

    try {
      List<Movie> movies = [];
      List<Movie> tvShows = [];

      if (type == TypeEnum.all || type == TypeEnum.movie) {
        movies = await getWatchlistMovies(548, '79191836ddaa0da3df76a5ffef6f07ad6ab0c641',1);
      }

      if (type == TypeEnum.all || type == TypeEnum.tv) {
        tvShows = await getWatchlistTvShows(548, '79191836ddaa0da3df76a5ffef6f07ad6ab0c641', 1);
      }

      if (type == TypeEnum.all) {
        final combined = [...movies, ...tvShows];
        combined.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
        watchlistItems.assignAll(combined);
      } else if (type == TypeEnum.movie) {
        watchlistItems.assignAll(movies);
      } else if (type == TypeEnum.tv) {
        watchlistItems.assignAll(tvShows);
      }
    } on DioException catch (e) {
      errorMessage.value = e.message ?? 'Network Error';
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
    }

    isLoading.value = false;
  }
}
