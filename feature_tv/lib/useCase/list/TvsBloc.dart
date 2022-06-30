import 'package:common_base/BaseBloc.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:feature_tv/repo/TvRepo.dart';
import 'package:feature_tv/repo/model/TvBy.dart';
import 'package:feature_tv/repo/model/TvsModel.dart';
import 'package:rxdart/rxdart.dart';

class TvsBloc extends BaseBloc {
  final TvRepo _tvRepo;

  TvsBloc({TvRepo? tvRepo}) : _tvRepo = tvRepo ?? TvRepo();

  int tvPage = 1;
  var loading = false;

  ///
  TvBy tvBy = TvBy.ON_THE_AIR;
  final BehaviorSubject<TvBy> _subjectTvBy =
      BehaviorSubject<TvBy>.seeded(TvBy.ON_THE_AIR);

  ValueStream<TvBy> get streamTvBy => _subjectTvBy.stream;

  ///
  List<Tv> tvs = [];
  final BehaviorSubject<List<Tv>?> _subjectTv =
      BehaviorSubject<List<Tv>?>.seeded(null);

  ValueStream<List<Tv>?> get streamTvs => _subjectTv.stream;

  ///
  initData() async {
    localStatus.notifyStatus(LocalStatus.isLoading);

    await loadTvs();

    if (getError() == null) {
      localStatus.notifyStatus(LocalStatus.isSuccess);
    } else {
      localStatus.notifyStatus(LocalStatus.isError);
    }
  }

  loadTvs() async {
    if (!loading) {
      loading = true;
      setError(null);
      switch (tvBy) {
        case TvBy.ON_THE_AIR:
          await _loadOnTheAir();
          break;
        case TvBy.POPULAR:
          await _loadPopular();
          break;
      }
      loading = false;
    }
  }

  _loadPopular() async {
    await _tvRepo.getPopular(tvPage).then((response) {
      if (response.error == null) {
        setTvs((response.data as TvsModel).results);
      } else {
        setError(response.error);
      }
    });
  }

  _loadOnTheAir() async {
    await _tvRepo.getOnAir(tvPage).then((response) {
      if (response.error == null) {
        setTvs((response.data as TvsModel).results);
      } else {
        setError(response.error);
      }
    });
  }

  getImagePath(String path) => _tvRepo.getImage(path);

  ///
  setTvs(List<Tv> newData) {
    if (newData.isNotEmpty) {
      tvs.addAll(newData);
      tvPage++;
      _subjectTv.sink.add(tvs);
    }
  }

  resetTv() async {
    tvs.clear();
    tvPage = 1;
    loadTvs();
  }

  ///
  setTvBy(int index) async {
    if (tvBy != TvBy.values[index]) {
      tvBy = TvBy.values[index];
      _subjectTvBy.sink.add(tvBy);
      await resetTv();
    }
  }

  @override
  void dispose() {
    _subjectTv.close();
    _subjectTvBy.close();
    super.dispose();
  }
}
