import 'package:common_network/BaseApiClient.dart';
import 'package:common_network/ErrorModel.dart';
import 'package:common_network/MessageModel.dart';
import 'package:dio/dio.dart';
import 'package:feature_tv/repo/model/TvDetailModel.dart';
import 'package:feature_tv/repo/model/TvsModel.dart';

class TvApiClient extends BaseApiClient {

  ///
  Future<MessageModel> getOnTheAir(int page) async {
    return handler.hitAPI(() async {
      Response<String> response = await getDio()
          .get("/tv/on_the_air?api_key=${getApiKey()}&page=$page");

      if (response.statusCode! >= 200 && response.statusCode! < 300)
        return MessageModel(tvsModelFromJson(response.data!), null);
      return MessageModel(
          null, errorModelFromJson(response.data!).statusMessage);
    });
  }

  Future<MessageModel> getPopular(int page) async {
    return handler.hitAPI(() async {
      Response<String> response =
          await getDio().get("/tv/popular?api_key=${getApiKey()}&page=$page");

      if (response.statusCode! >= 200 && response.statusCode! < 300)
        return MessageModel(tvsModelFromJson(response.data!), null);
      return MessageModel(
          null, errorModelFromJson(response.data!).statusMessage);
    });
  }

  Future<MessageModel> getDetail(String tvId) async {
    return handler.hitAPI(() async {
      Response<String> response =
          await getDio().get("/tv/$tvId?api_key=${getApiKey()}");

      if (response.statusCode! >= 200 && response.statusCode! < 300)
        return MessageModel(tvDetailModelFromJson(response.data!), null);
      return MessageModel(
          null, errorModelFromJson(response.data!).statusMessage);
    });
  }
}
