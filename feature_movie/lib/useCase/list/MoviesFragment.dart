import 'package:common_base/AssetsColor.dart';
import 'package:common_base/BaseListWidget.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:common_base/PageRoutes.dart';
import 'package:feature_movie/repo/MovieRepo.dart';
import 'package:feature_movie/repo/model/MovieBy.dart';
import 'package:feature_movie/repo/model/MoviesModel.dart';
import 'package:feature_movie/useCase/list/MovieAdapter.dart';
import 'package:feature_movie/useCase/list/MoviesBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesFragment extends BaseListWidget {
  @override
  State<MoviesFragment> createState() => _MoviesState();
}

class _MoviesState extends BaseListState<MoviesFragment> {
  late MoviesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MoviesBloc(movieRepo: context.read<MovieRepoProvider>().repo);
    _bloc.initData();
  }

  @override
  Color getBackgroundColor() => AssetsColor.ColorGreen1;

  @override
  Widget getBody() => StreamBuilder(
        initialData: _bloc.localStatus.subjectStatus,
        stream: _bloc.localStatus.observableStatus,
        builder: (ctx, snapshot) {
          switch (snapshot.data) {
            case LocalStatus.isSuccess:
              return _viewContent();
            case LocalStatus.isError:
              return Center(
                  child:
                      Text("Error: ${_bloc.getError() ?? "Something Wrong"}"));
            case LocalStatus.isLoading:
            default:
              return const Center(child: Text("Loading ..."));
          }
        },
      );

  Widget _viewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
          child: const Text(
            "Movies",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
        ),
        _viewMovieBy(),
        _viewMovies(),
      ],
    );
  }

  Widget _viewMovieBy() => StreamBuilder(
        stream: _bloc.streamMovieBy,
        builder: (ctx, snapshot) {
          var data = snapshot.data as MovieBy?;
          if (data == null) return Container();
          return Container(
            height: 32,
            margin: const EdgeInsets.only(bottom: 24),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: MovieBy.values.length,
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 32,
                    margin: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {
                        _onMovieByClick(index);
                      },
                      child: Chip(
                        backgroundColor: data == MovieBy.values[index]
                            ? AssetsColor.ColorGreen2
                            : AssetsColor.ColorGrey1,
                        label: Text(
                          movieByText(MovieBy.values[index]),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      );

  String movieByText(MovieBy movieBy) {
    switch (movieBy) {
      case MovieBy.POPULAR:
        return "Popular";
      case MovieBy.NOW_PLAYING:
        return "Now Playing";
      case MovieBy.UP_COMING:
        return "Up Coming";
    }
  }

  Widget _viewMovies() => StreamBuilder(
        stream: _bloc.streamMovies,
        builder: (ctx, snapshot) {
          var data = snapshot.data as List<Movie>?;
          if (data == null) return Container();
          if (data.isEmpty) return _viewEmpty();
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data.length,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              itemBuilder: (BuildContext context, int index) {
                var movie = data[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: MovieAdapter(movie,
                      _bloc.getImagePath(movie.posterPath), _onMovieClick),
                );
              });
        },
      );

  Widget _viewEmpty() => const Center(child: Text("Kosong"));

  ///
  @override
  onLoadMore() {
    _bloc.loadMovies();
  }

  @override
  onRefresh() async {
    await _bloc.resetMovies();
  }

  _onMovieByClick(int index) {
    _bloc.setMovieBy(index);
  }

  _onMovieClick(int movieId) {
    Navigator.of(context)
        .pushNamed(PageRoutes.linkDetailMovie, arguments: {"01": movieId});
  }
}
