import 'package:common_network/BaseApiClient.dart';
import 'package:common_network/ErrorModel.dart';
import 'package:common_network/MessageModel.dart';
import 'package:dio/dio.dart';
import 'package:feature_movie/repo/model/MovieDetailModel.dart';
import 'package:feature_movie/repo/model/MoviesModel.dart';

class MovieApiClient extends BaseApiClient {
  ///
  Future<MessageModel> getNowPlaying(int page) async {
    return handler.hitAPI(() async {
      Response<String> response = await getDio()
          .get("/movie/now_playing?api_key=${getApiKey()}&page=$page");

      if (response.statusCode! >= 200 && response.statusCode! < 300)
        return MessageModel(moviesModelFromJson(response.data!), null);
      return MessageModel(
          null, errorModelFromJson(response.data!).statusMessage);
    });
  }

  Future<MessageModel> getUpComing(int page) async {
    return handler.hitAPI(() async {
      Response<String> response = await getDio()
          .get("/movie/upcoming?api_key=${getApiKey()}&page=$page");

      if (response.statusCode! >= 200 && response.statusCode! < 300)
        return MessageModel(moviesModelFromJson(response.data!), null);
      return MessageModel(
          null, errorModelFromJson(response.data!).statusMessage);
    });
  }

  Future<MessageModel> getPopular(int page) async {
    return handler.hitAPI(() async {
      Response<String> response = await getDio()
          .get("/movie/popular?api_key=${getApiKey()}&page=$page");
      if (response.statusCode! >= 200 && response.statusCode! < 300)
        return MessageModel(moviesModelFromJson(response.data!), null);
      return MessageModel(
          null, errorModelFromJson(response.data!).statusMessage);
    });
  }

  Future<MessageModel> getDetail(String movieId) async {
    return handler.hitAPI(() async {
      Response<String> response =
          await getDio().get("/movie/$movieId?api_key=${getApiKey()}");

      if (response.statusCode! >= 200 && response.statusCode! < 300)
        return MessageModel(movieDetailModelFromJson(response.data!), null);
      return MessageModel(
          null, errorModelFromJson(response.data!).statusMessage);
    });
  }
}
