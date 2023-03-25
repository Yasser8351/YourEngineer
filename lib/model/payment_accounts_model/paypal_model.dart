// To parse this JSON data, do
//
//     final paypalModel = paypalModelFromJson(jsonString);

import 'dart:convert';

PaypalModel paypalModelFromJson(String str) =>
    PaypalModel.fromJson(json.decode(str));

String paypalModelToJson(PaypalModel data) => json.encode(data.toJson());

class PaypalModel {
  PaypalModel({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String email;
  final String createdAt;
  final String updatedAt;

  factory PaypalModel.fromJson(Map<String, dynamic> json) => PaypalModel(
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
