import 'package:flutter_app/bindings/detail_movie_binding.dart';
import 'package:flutter_app/modules/detail_movie/presentation/pages/detail_movie_page.dart';
import 'package:flutter_app/modules/home/domain/usecases/get_genres.dart';
import 'package:flutter_app/modules/home/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_app/modules/home/presentation/pages/list_movie_page.dart';
import 'package:flutter_app/modules/profile/presentation/controllers/profile_controller.dart';
import 'package:flutter_app/modules/profile/presentation/pages/profile_page.dart';
import 'package:flutter_app/modules/watchlist/presentation/pages/watchlist_page.dart';
import 'package:get/get.dart';

import '../../modules/home/data/remote/movie_remote_data_source.dart';
import '../../modules/home/domain/repositories/movie_repository_impl.dart';
import '../../modules/home/domain/usecases/get_now_playing_movies.dart';
import '../../modules/home/domain/usecases/get_trending_movies.dart';
import '../../modules/home/presentation/controllers/home_controller.dart';
import '../../modules/home/presentation/pages/home_page.dart';
import '../../modules/login/presentation/controller/login_controller.dart';
import '../../modules/login/presentation/pages/login_page.dart';
import '../../modules/profile/data/remote/profile_data_source.dart';
import '../../modules/profile/domain/repositories/profile_repository_impl.dart';
import '../../modules/profile/domain/usecases/get_profile.dart';
import '../../modules/splash/presentation/pages/splash_page.dart';
import '../../modules/watchlist/data/remote/watchlist_data_source.dart';
import '../../modules/watchlist/domain/repositories/watchlist_repository_impl.dart';
import '../../modules/watchlist/domain/usecases/get_watchlist.dart';
import '../../modules/watchlist/presentation/controllers/watchlist_controller.dart';
import '../network/dio_client.dart';

part 'app_routes.dart';

const apiKey = 'd1bda657d32391f31896de3d56bd758f';
final dioClient = DioClient(apiKey);
final dio = dioClient.dio;

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        final homeRemoteDataSource = MovieRemoteDataSourceImpl(dio);
        final homeRepo = MovieRepositoryImpl(homeRemoteDataSource);
        final getTrending = GetTrendingMovies(homeRepo);
        final getNowPlaying = GetNowPlayingMovies(homeRepo);
        final getTopRated = GetTopRatedMovies(homeRepo);
        final getGenre = GetGenres(homeRepo);

        Get.put(HomeController(
          getTrending: getTrending,
          getNowPlaying: getNowPlaying,
          getTopRated: getTopRated,
          getGenres: getGenre,
        ));
        final profileRemoteDataSource = ProfileRemoteDataSourceImpl(dio);
        final profileRepo = ProfileRepositoryImpl(profileRemoteDataSource);
        final getProfile = GetProfile(profileRepo);
        Get.put(
          ProfileController(getProfile: getProfile),
        );

        final watchlistRemoteDataSource = WatchlistRemoteDataSourceImpl(dio);
        final watchlistRepo =
            WatchlistRepositoryImpl(watchlistRemoteDataSource);
        final getWatchlistMovies = GetWatchlistMovies(watchlistRepo);
        final getWatchlistTvShows = GetWatchlistTvShows(watchlistRepo);

        Get.put(
          WatchlistController(
            getWatchlistMovies: getWatchlistMovies,
            getWatchlistTvShows: getWatchlistTvShows,
          ),
        );
      }),
    ),
    GetPage(
      name: Routes.detailMovie,
      page: () => const DetailMoviePage(),
      binding: DetailMovieBinding(),
    ),
    GetPage(
      name: Routes.listMovie,
      page: () => const ListMoviePage(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: Routes.watchlist,
      page: () => const WatchlistPage(),
    ),
  ];
}
