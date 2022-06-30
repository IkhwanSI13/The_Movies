import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_base/AssetsColor.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:feature_tv/repo/TvRepo.dart';
import 'package:feature_tv/repo/model/TvDetailModel.dart';
import 'package:feature_tv/useCase/detail/TvDetailBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvDetailActivity extends StatefulWidget {
  final int tvId;

  TvDetailActivity(this.tvId);

  @override
  State<TvDetailActivity> createState() => TvDetailState();
}

class TvDetailState extends State<TvDetailActivity> {
  late TvDetailBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = TvDetailBloc(tvRepo: context.read<TvRepoProvider>().repo);
    _bloc.initData(widget.tvId);
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
      stream: _bloc.streamTv,
      builder: (ctx, snapshot) {
        var tvDetail = snapshot.data as TvDetail?;
        if (tvDetail == null) return Container();
        return SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [_viewHeader(tvDetail), ..._viewDesc(tvDetail)]),
        );
      });

  Widget _viewHeader(TvDetail tvDetail) => SizedBox(
        height: 280,
        child: Stack(
          children: [
            CachedNetworkImage(
                imageUrl: _bloc.getImagePath(tvDetail.backdropPath),
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
                imageUrl: _bloc.getImagePath(tvDetail.posterPath),
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
                                  offset: const Offset(
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

  List<Widget> _viewDesc(TvDetail tvDetail) => [
        Container(
            margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Text(
              tvDetail.name,
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
              Text("${tvDetail.voteAverage} / 10",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AssetsColor.ColorYellow2))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          child: Text(tvDetail.overview, style: const TextStyle(fontSize: 16)),
        ),
        if (_bloc.getGenre().isNotEmpty)
          Container(
            margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Text(
              "Genre: ${_bloc.getGenre()}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        if (tvDetail.tagline.isNotEmpty)
          Container(
            margin: const EdgeInsets.fromLTRB(24, 4, 24, 0),
            child: Text("Tagline: ${tvDetail.tagline}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          )
      ];
}
