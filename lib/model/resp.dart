// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    required this.success,
    required this.msg,
  });

  final bool success;
  final String msg;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        success: json["success"] ?? false,
        msg: json["msg"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
      };
}
