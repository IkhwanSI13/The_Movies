import 'package:common_base/LocalStatus.dart';

abstract class BaseBloc {
  LocalStatus localStatus = LocalStatus();
  String? _error;

  bool errorShowed = false;

  setError(String? newData) {
    _error = newData;
  }

  String? getError() => _error;

  bool isError() {
    if (getError() != null) return true;
    return false;
  }

  void dispose() {
    localStatus.dispose();
  }
}
