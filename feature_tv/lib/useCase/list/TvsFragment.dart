import 'package:common_base/AssetsColor.dart';
import 'package:common_base/BaseListWidget.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:common_base/PageRoutes.dart';
import 'package:feature_tv/repo/TvRepo.dart';
import 'package:feature_tv/repo/model/TvBy.dart';
import 'package:feature_tv/repo/model/TvsModel.dart';
import 'package:feature_tv/useCase/list/TvAdapter.dart';
import 'package:feature_tv/useCase/list/TvsBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvFragment extends BaseListWidget {
  @override
  State<TvFragment> createState() => _TvState();
}

class _TvState extends BaseListState<TvFragment> {
  late TvsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TvsBloc(tvRepo: context.read<TvRepoProvider>().repo);
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
            "Tv",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
        ),
        _viewMovieBy(),
        _viewMovies(),
      ],
    );
  }

  Widget _viewMovieBy() => StreamBuilder(
        stream: _bloc.streamTvBy,
        builder: (ctx, snapshot) {
          var data = snapshot.data as TvBy?;
          if (data == null) return Container();
          return Container(
            height: 32,
            margin: const EdgeInsets.only(bottom: 24),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: TvBy.values.length,
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
                        backgroundColor: data == TvBy.values[index]
                            ? AssetsColor.ColorGreen2
                            : AssetsColor.ColorGrey1,
                        label: Text(
                          tvByText(TvBy.values[index]),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      );

  String tvByText(TvBy movieBy) {
    switch (movieBy) {
      case TvBy.ON_THE_AIR:
        return "On The Air";
      case TvBy.POPULAR:
        return "Popular";
    }
  }

  Widget _viewMovies() => StreamBuilder(
        stream: _bloc.streamTvs,
        builder: (ctx, snapshot) {
          var data = snapshot.data as List<Tv>?;
          if (data == null) return Container();
          if (data.isEmpty) return _viewEmpty();
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data.length,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              itemBuilder: (BuildContext context, int index) {
                var tv = data[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: TvAdapter(
                      tv, _bloc.getImagePath(tv.posterPath), _onMovieClick),
                );
              });
        },
      );

  Widget _viewEmpty() => const Center(child: Text("Kosong"));

  ///
  @override
  onLoadMore() {
    _bloc.loadTvs();
  }

  @override
  onRefresh() async {
    await _bloc.resetTv();
  }

  _onMovieByClick(int index) {
    _bloc.setTvBy(index);
  }

  _onMovieClick(int id) {
    Navigator.of(context)
        .pushNamed(PageRoutes.linkDetailTv, arguments: {"01": id});
  }
}
