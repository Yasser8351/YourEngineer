// To parse this JSON data, do
//
//     final priceRangeModel = priceRangeModelFromJson(jsonString);

import 'dart:convert';

List<PriceRangeModel> priceRangeModelFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<PriceRangeModel>.from(
            json.decode(str)!.map((x) => PriceRangeModel.fromJson(x)));

String priceRangeModelToJson(List<PriceRangeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PriceRangeModel {
  PriceRangeModel({
    this.id,
    this.rangeName,
    this.rangeFrom,
    this.rangeTo,
  });

  String? id;
  String? rangeName;
  String? rangeFrom;
  String? rangeTo;

  factory PriceRangeModel.fromJson(Map<String, dynamic> json) =>
      PriceRangeModel(
        id: json["id"] ?? '',
        rangeName: json["range_name"] ?? '',
        rangeFrom: json["range_from"] ?? '',
        rangeTo: json["range_to"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "range_name": rangeName,
        "range_from": rangeFrom,
        "range_to": rangeTo,
      };
}
