import 'package:common_network/MessageModel.dart';
import 'package:feature_tv/repo/api/TvApiClient.dart';
import 'package:flutter/widgets.dart';

class TvRepoProvider with ChangeNotifier {
  final TvRepo _repo = TvRepo();

  TvRepo get repo => _repo;
}

class TvRepo {
  /// A bridge for online and offline data
  /// Save data from online to local here
  TvApiClient _apiClient = TvApiClient();

  String getImage(String path) => _apiClient.getImage(path);

  ///API

  Future<MessageModel> getOnAir(int page) async =>
      await _apiClient.getOnTheAir(page);

  Future<MessageModel> getPopular(int page) async =>
      await _apiClient.getPopular(page);

  Future<MessageModel> getDetail(String movieId) async =>
      await _apiClient.getDetail(movieId);
}
