import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient(String apiKey)
      : dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {'api_key': apiKey},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
}
