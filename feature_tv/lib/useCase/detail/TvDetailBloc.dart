import 'package:common_base/BaseBloc.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:feature_tv/repo/TvRepo.dart';
import 'package:feature_tv/repo/model/TvDetailModel.dart';
import 'package:rxdart/rxdart.dart';

class TvDetailBloc extends BaseBloc {
  final TvRepo _tvRepo;

  TvDetailBloc({TvRepo? tvRepo}) : _tvRepo = tvRepo ?? TvRepo();

  ///
  TvDetail? _tvDetail;
  final BehaviorSubject<TvDetail?> _subjectTv =
      BehaviorSubject<TvDetail?>.seeded(null);

  ValueStream<TvDetail?> get streamTv => _subjectTv.stream;

  ///
  initData(int tvId) async {
    localStatus.notifyStatus(LocalStatus.isLoading);

    await loadTv(tvId);

    if (getError() == null) {
      localStatus.notifyStatus(LocalStatus.isSuccess);
    } else {
      localStatus.notifyStatus(LocalStatus.isError);
    }
  }

  loadTv(int tvId) async {
    await _tvRepo.getDetail(tvId.toString()).then((response) {
      if (response.error == null) {
        setTv((response.data as TvDetail));
      } else {
        setError(response.error);
      }
    });
  }

  getImagePath(String path) => _tvRepo.getImage(path);

  String getGenre() {
    var result = '';
    if (_tvDetail?.genres != null) {
      for (var genre in _tvDetail!.genres) {
        result += "${genre.name}, ";
      }
      if (result.isNotEmpty) {
        result = result.substring(0, result.length - 2);
      }
    }

    return result;
  }

  ///
  setTv(TvDetail newData) {
    _tvDetail = newData;
    _subjectTv.sink.add(_tvDetail);
  }

  @override
  void dispose() {
    _subjectTv.close();
    super.dispose();
  }
}
