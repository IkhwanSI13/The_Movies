import 'package:rxdart/rxdart.dart';

class LocalStatus {
  static const isPrepare = 0;
  static const isLoading = 1;
  static const isSuccess = 2;
  static const isError = 3;

  int _status = isPrepare;

  BehaviorSubject<int> subjectStatus = BehaviorSubject<int>.seeded(isPrepare);

  ValueStream<int> get observableStatus => subjectStatus.stream;

  int getStatus() => _status;

  notifyStatus(int newStatus) {
    _status = newStatus;
    if (!subjectStatus.isClosed) subjectStatus.sink.add(_status);
  }

  dispose() {
    subjectStatus.close();
  }
}
