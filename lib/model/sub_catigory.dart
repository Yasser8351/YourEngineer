// To parse this JSON data, do
//
//     final subCatigory = subCatigoryFromJson(jsonString);

import 'dart:convert';

List<SubCatigoryModel> subCatigoryFromJson(String str) =>
    List<SubCatigoryModel>.from(
        json.decode(str)!.map((x) => SubCatigoryModel.fromJson(x)));

String subCatigoryToJson(List<SubCatigoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// String subCatigoryToJson(List<SubCatigory?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class SubCatigoryModel {
  SubCatigoryModel({
    this.id,
    this.name,
    this.catId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? catId;
  String? createdAt;
  String? updatedAt;

  factory SubCatigoryModel.fromJson(Map<String, dynamic> json) =>
      SubCatigoryModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        catId: json["cat_id"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cat_id": catId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
