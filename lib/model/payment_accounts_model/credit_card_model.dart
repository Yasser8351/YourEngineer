// To parse this JSON data, do
//
//     final creditCardModel = creditCardModelFromJson(jsonString);

import 'dart:convert';

CreditCardModel creditCardModelFromJson(String str) =>
    CreditCardModel.fromJson(json.decode(str));

String creditCardModelToJson(CreditCardModel data) =>
    json.encode(data.toJson());

class CreditCardModel {
  CreditCardModel({
    required this.name,
    required this.number,
  });

  final String name;
  final String number;

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      CreditCardModel(
        name: json["name"] ?? '',
        number: json["number"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
      };
}
