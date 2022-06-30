import 'package:common_base/BaseBloc.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:feature_movie/repo/MovieRepo.dart';
import 'package:feature_movie/repo/model/MovieDetailModel.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc extends BaseBloc {
  final MovieRepo _movieRepo;

  MovieDetailBloc({MovieRepo? movieRepo})
      : _movieRepo = movieRepo ?? MovieRepo();

  ///
  MovieDetail? _movieDetail;
  final BehaviorSubject<MovieDetail?> _subjectMovie =
      BehaviorSubject<MovieDetail?>.seeded(null);

  ValueStream<MovieDetail?> get streamMovie => _subjectMovie.stream;

  ///
  initData(int movieId) async {
    localStatus.notifyStatus(LocalStatus.isLoading);

    await loadMovie(movieId);

    if (getError() == null) {
      localStatus.notifyStatus(LocalStatus.isSuccess);
    } else {
      localStatus.notifyStatus(LocalStatus.isError);
    }
  }

  loadMovie(int movieId) async {
    await _movieRepo.getDetail(movieId.toString()).then((response) {
      if (response.error == null) {
        setMovies((response.data as MovieDetail));
      } else {
        setError(response.error);
      }
    });
  }

  getImagePath(String path) => _movieRepo.getMovieImage(path);

  String getGenre() {
    var result = '';
    if (_movieDetail?.genres != null) {
      for (var genre in _movieDetail!.genres) {
        result += "${genre.name}, ";
      }
      if (result.isNotEmpty) {
        result = result.substring(0, result.length - 2);
      }
    }

    return result;
  }

  ///
  setMovies(MovieDetail newData) {
    _movieDetail = newData;
    _subjectMovie.sink.add(_movieDetail);
  }

  @override
  void dispose() {
    _subjectMovie.close();
    super.dispose();
  }
}
