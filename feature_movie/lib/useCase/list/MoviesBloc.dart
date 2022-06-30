import 'package:common_base/BaseBloc.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:feature_movie/repo/MovieRepo.dart';
import 'package:feature_movie/repo/model/MovieBy.dart';
import 'package:feature_movie/repo/model/MoviesModel.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc extends BaseBloc {
  final MovieRepo _movieRepo;

  MoviesBloc({MovieRepo? movieRepo}) : _movieRepo = movieRepo ?? MovieRepo();

  int moviePage = 1;
  var loading = false;

  ///
  MovieBy movieBy = MovieBy.POPULAR;
  final BehaviorSubject<MovieBy> _subjectMovieBy =
      BehaviorSubject<MovieBy>.seeded(MovieBy.POPULAR);

  ValueStream<MovieBy> get streamMovieBy => _subjectMovieBy.stream;

  ///
  List<Movie> movies = [];
  final BehaviorSubject<List<Movie>?> _subjectMovies =
      BehaviorSubject<List<Movie>?>.seeded(null);

  ValueStream<List<Movie>?> get streamMovies => _subjectMovies.stream;

  ///
  initData() async {
    localStatus.notifyStatus(LocalStatus.isLoading);

    await loadMovies();

    if (getError() == null) {
      localStatus.notifyStatus(LocalStatus.isSuccess);
    } else {
      localStatus.notifyStatus(LocalStatus.isError);
    }
  }

  loadMovies() async {
    if (!loading) {
      loading = true;
      setError(null);
      switch (movieBy) {
        case MovieBy.POPULAR:
          await _loadMoviesPopular();
          break;
        case MovieBy.NOW_PLAYING:
          await _loadMoviesNowPlaying();
          break;
        case MovieBy.UP_COMING:
          await _loadMoviesUpComing();
          break;
      }
      loading = false;
    }
  }

  _loadMoviesPopular() async {
    await _movieRepo.getPopular(moviePage).then((response) {
      if (response.error == null) {
        setMovies((response.data as MoviesModel).results);
      } else {
        setError(response.error);
      }
    });
  }

  _loadMoviesNowPlaying() async {
    await _movieRepo.getNowPlaying(moviePage).then((response) {
      if (response.error == null) {
        setMovies((response.data as MoviesModel).results);
      } else {
        setError(response.error);
      }
    });
  }

  _loadMoviesUpComing() async {
    await _movieRepo.getUpComing(moviePage).then((response) {
      if (response.error == null) {
        setMovies((response.data as MoviesModel).results);
      } else {
        setError(response.error);
      }
    });
  }

  getImagePath(String path) => _movieRepo.getMovieImage(path);

  ///
  setMovies(List<Movie> newData) {
    if (newData.isNotEmpty) {
      movies.addAll(newData);
      moviePage++;
      _subjectMovies.sink.add(movies);
    }
  }

  resetMovies() async {
    movies.clear();
    moviePage = 1;
    await loadMovies();
  }

  ///
  setMovieBy(int index) async {
    if (movieBy != MovieBy.values[index]) {
      movieBy = MovieBy.values[index];
      _subjectMovieBy.sink.add(movieBy);
      await resetMovies();
    }
  }

  @override
  void dispose() {
    _subjectMovies.close();
    _subjectMovieBy.close();
    super.dispose();
  }
}
