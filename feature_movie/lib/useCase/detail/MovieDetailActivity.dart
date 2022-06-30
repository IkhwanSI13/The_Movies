import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_base/AssetsColor.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:feature_movie/repo/MovieRepo.dart';
import 'package:feature_movie/repo/model/MovieDetailModel.dart';
import 'package:feature_movie/useCase/detail/MovieDetailBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailActivity extends StatefulWidget {
  final int movieId;

  MovieDetailActivity(this.movieId);

  @override
  State<MovieDetailActivity> createState() => MovieDetailState();
}

class MovieDetailState extends State<MovieDetailActivity> {
  late MovieDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MovieDetailBloc(movieRepo: context.read<MovieRepoProvider>().repo);
    _bloc.initData(widget.movieId);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
          initialData: _bloc.localStatus.subjectStatus,
          stream: _bloc.localStatus.observableStatus,
          builder: (ctx, snapshot) {
            switch (snapshot.data) {
              case LocalStatus.isSuccess:
                return _viewContent();
              case LocalStatus.isError:
                return Center(
                    child: Text(
                        "Error: ${_bloc.getError() ?? "Something Wrong"}"));
              case LocalStatus.isLoading:
              default:
                return const Center(child: Text("Loading ..."));
            }
          }));

  Widget _viewContent() => StreamBuilder(
      stream: _bloc.streamMovie,
      builder: (ctx, snapshot) {
        var movieDetail = snapshot.data as MovieDetail?;
        if (movieDetail == null) return Container();
        return SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [_viewHeader(movieDetail), ..._viewDesc(movieDetail)]),
        );
      });

  Widget _viewHeader(MovieDetail movieDetail) => SizedBox(
        height: 280,
        child: Stack(
          children: [
            CachedNetworkImage(
                imageUrl: _bloc.getImagePath(movieDetail.backdropPath),
                imageBuilder: (context, imageProvider) => Container(
                    margin: const EdgeInsets.only(bottom: 42),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                                AssetsColor.ColorGreen1,
                                BlendMode.colorBurn)))),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error))),
            CachedNetworkImage(
                imageUrl: _bloc.getImagePath(movieDetail.posterPath),
                imageBuilder: (context, imageProvider) => Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                          width: 137,
                          height: 206,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AssetsColor.ColorGreen1.withOpacity(0.8),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ))),
                    ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)))
          ],
        ),
      );

  List<Widget> _viewDesc(MovieDetail movieDetail) => [
        Container(
            margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Text(
              movieDetail.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AssetsColor.ColorGreen2),
            )),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 4, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: AssetsColor.ColorYellow2),
              Container(width: 8),
              Text("${movieDetail.voteAverage} / 10",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AssetsColor.ColorYellow2))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          child:
              Text(movieDetail.overview, style: const TextStyle(fontSize: 16)),
        ),
        if (_bloc.getGenre().isNotEmpty)
          Container(
            margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Text(
              "Genre: ${_bloc.getGenre()}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        if (movieDetail.tagline.isNotEmpty)
          Container(
            margin: const EdgeInsets.fromLTRB(24, 4, 24, 0),
            child: Text("Tagline: ${movieDetail.tagline}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          )
      ];
}
