import 'package:flutter_app/modules/home/domain/entities/genre.dart';
import 'package:flutter_app/modules/home/domain/usecases/get_genres.dart';
import 'package:flutter_app/modules/home/domain/usecases/get_top_rated_movies.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/type_chip.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/get_trending_movies.dart';

class HomeController extends GetxController {
  final GetTrendingMovies getTrending;
  final GetNowPlayingMovies getNowPlaying;
  final GetTopRatedMovies getTopRated;
  final GetGenres getGenres;

  HomeController({
    required this.getTrending,
    required this.getNowPlaying,
    required this.getTopRated,
    required this.getGenres,
  });

  var appBarTitle = ''.obs;
  var trendingMovies = <Movie>[].obs;
  var nowPlayingMovies = <Movie>[].obs;
  var topRatedMovies = <Movie>[].obs;
  var allListMovies = <Movie>[].obs;
  var genres = <Genre>[].obs;
  var isLoading = false.obs;
  final Rx<TypeEnum> selectedType = TypeEnum.all.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    print('DEBUG: Get.arguments = $args');
    if (args == null) {
      appBarTitle.value = 'List';
    } else if (args is String) {
      appBarTitle.value = args;
    }
    fetchMovies();
  }

  Future<void> fetchMovies({TypeEnum type = TypeEnum.all}) async {
    isLoading.value = true;
    trendingMovies.value = await getTrending.execute();
    nowPlayingMovies.value = await getNowPlaying.execute();
    topRatedMovies.value = await getTopRated.execute();
    genres.value = await getGenres.execute();
    isLoading.value = false;
  }

  Future<void> refreshMovies() async {
    await fetchMovies();
  }

  void setListTitle(String title) {
    appBarTitle.value = title;
    if (title == 'Trending') {
      allListMovies.value = trendingMovies;
    } else if (title == 'Baru Rilis') {
      allListMovies.value = nowPlayingMovies;
    } else {
      allListMovies.value = topRatedMovies;
    }
  }

  void selectType(TypeEnum type) {
    if (selectedType.value != type) {
      selectedType.value = type;
      // fetchMovies(type);
    }
  }
}
