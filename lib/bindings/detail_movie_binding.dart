
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../modules/detail_movie/data/remote/detail_movie_data_source.dart';
import '../modules/detail_movie/domain/repositories/detail_movie_repository.dart';
import '../modules/detail_movie/domain/repositories/detail_movie_repository_impl.dart';
import '../modules/detail_movie/domain/usecases/get_detail_movie.dart';
import '../modules/detail_movie/domain/usecases/get_review.dart';
import '../modules/detail_movie/presentation/controllers/detail_movie_controller.dart';

class DetailMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() {
      return Dio(BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        queryParameters: {'api_key': 'd1bda657d32391f31896de3d56bd758f'},
      ));
    });
    Get.lazyPut<DetailMovieRemoteDataSource>(() => DetailMovieRemoteDataSourceImpl(Get.find()));

    Get.lazyPut<DetailMovieRepository>(() => DetailMovieRepositoryImpl(Get.find()));

    Get.lazyPut<GetDetailMovie>(() => GetDetailMovie(Get.find()));
    Get.lazyPut<GetReview>(() => GetReview(Get.find()));

    Get.put<DetailMovieController>(
      DetailMovieController(getDetailMovie: Get.find(), getReview: Get.find()),
    );
  }
}