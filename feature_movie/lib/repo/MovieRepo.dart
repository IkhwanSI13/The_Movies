import 'package:common_network/MessageModel.dart';
import 'package:feature_movie/repo/api/MovieApiClient.dart';
import 'package:flutter/widgets.dart';

class MovieRepoProvider with ChangeNotifier {
  final MovieRepo _repo = MovieRepo();

  MovieRepo get repo => _repo;
}

class MovieRepo {
  /// A bridge for online and offline data
  /// Save data from online to local here

  MovieApiClient _apiClient = MovieApiClient();

  String getMovieImage(String path) => _apiClient.getImage(path);

  ///API

  Future<MessageModel> getNowPlaying(int page) async =>
      await _apiClient.getNowPlaying(page);

  Future<MessageModel> getUpComing(int page) async =>
      await _apiClient.getUpComing(page);

  Future<MessageModel> getPopular(int page) async =>
      await _apiClient.getPopular(page);

  Future<MessageModel> getDetail(String movieId) async =>
      await _apiClient.getDetail(movieId);
}
