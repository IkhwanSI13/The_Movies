import 'package:common_network/ResponseHandler.dart';
import 'package:dio/dio.dart';

class BaseApiClient {
  late ResponseHandler handler;

  BaseApiClient() {
    handler = ResponseHandler();
  }

  String getApiKey() => " YOUR API KEY " ;

  String getUrl() => "https://api.themoviedb.org/3";

  Dio getDio({interceptor = false}) {
    Dio dio = Dio(BaseOptions(
        baseUrl: getUrl(),
        //Make future run without catchError with status < 500
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
        // 5000 = 5 second
        connectTimeout: 15000,
        receiveTimeout: 15000));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }

  ///
  Options getHeader() => Options(headers: {
        "Content-Type": "application/json"
        // , "token": token
      });

  ///
  String getImage(String path) => "https://image.tmdb.org/t/p/w300$path";
}
