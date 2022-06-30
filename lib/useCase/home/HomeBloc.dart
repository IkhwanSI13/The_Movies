import 'package:common_base/BaseBloc.dart';
import 'package:common_base/LocalStatus.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  int selectedMenu = 0;

  HomeBloc({this.selectedMenu = 0});

  final BehaviorSubject<int> _subjectMenu = BehaviorSubject<int>.seeded(0);

  ValueStream<int> get streamMenu => _subjectMenu.stream;

  ///
  initData() async {
    localStatus.notifyStatus(LocalStatus.isLoading);

    /// Load data

    if (getError() == null) {
      localStatus.notifyStatus(LocalStatus.isSuccess);
    } else {
      localStatus.notifyStatus(LocalStatus.isError);
    }
  }

  setMenu(int i) async {
    selectedMenu = i;
    _subjectMenu.sink.add(selectedMenu);
  }

  @override
  void dispose() {
    _subjectMenu.close();
    super.dispose();
  }
}
