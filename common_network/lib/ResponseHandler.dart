import 'dart:io';

import 'package:common_network/MessageModel.dart';
import 'package:dio/dio.dart';

class ResponseHandler {
  Future<MessageModel> hitAPI(Future<MessageModel> Function() onHandle) async {
    var connection = await checkConnection();
    if (connection != null) return connection;

    try {
      return await onHandle();
    } on DioError catch (e) {
      return MessageModel(null, e.message);
    } catch (e) {
      return MessageModel(null, e.toString());
    }
  }

  Future<MessageModel?> checkConnection() async {
    try {
      final testGoogle = await InternetAddress.lookup('google.com');

      if (testGoogle.isEmpty || testGoogle[0].rawAddress.isEmpty)
        return MessageModel(null, "Unable to access the page for a while");
      return null;
    } on SocketException catch (_) {
      return MessageModel(null, "Opss, Internet Anda mati");
    }
  }
}
