import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    this.statusMessage,
    this.statusCode,
  });

  String? statusMessage;
  int? statusCode;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        statusMessage: json["status_message"] ?? "Something Wrong",
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "status_message": statusMessage,
        "status_code": statusCode,
      };
}
