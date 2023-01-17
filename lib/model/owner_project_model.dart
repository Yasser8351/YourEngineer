// To parse this JSON data, do
//
//     final ownerProjectModel = ownerProjectModelFromJson(jsonString);

import 'dart:convert';

List<OwnerProjectModel> ownerProjectModelFromJson(String str) =>
    List<OwnerProjectModel>.from(
        json.decode(str)!.map((x) => OwnerProjectModel.fromJson(x)));

String ownerProjectModelToJson(List<OwnerProjectModel> data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())));

class OwnerProjectModel {
  OwnerProjectModel({
    required this.id,
    required this.projTitle,
    required this.projDescription,
    required this.skills,
    required this.projPeriod,
    required this.createdAt,
    required this.offersCount,
    this.subCategory,
    this.priceRange,
    this.projStatus,
  });

  String id;
  String projTitle;
  String projDescription;
  String skills;
  int projPeriod;
  String createdAt;
  int offersCount;
  SubCategory? subCategory;
  PriceRange? priceRange;
  ProjStatus? projStatus;

  factory OwnerProjectModel.fromJson(Map<String, dynamic> json) =>
      OwnerProjectModel(
        id: json["id"] ?? '',
        projTitle: json["proj_title"] ?? '',
        projDescription: json["proj_description"] ?? '',
        skills: json["skills"] ?? '',
        projPeriod: json["proj_period"] ?? '',
        createdAt: json["CreatedAt"] ?? '',
        offersCount: json["OffersCount"] ?? '',
        subCategory: SubCategory.fromJson(json["SubCategory"]),
        priceRange: PriceRange.fromJson(json["PriceRange"]),
        projStatus: ProjStatus.fromJson(json["ProjStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "proj_title": projTitle,
        "proj_description": projDescription,
        "skills": skills,
        "proj_period": projPeriod,
        "CreatedAt": createdAt,
        "OffersCount": offersCount,
        "SubCategory": subCategory!.toJson(),
        "PriceRange": priceRange!.toJson(),
        "ProjStatus": projStatus!.toJson(),
      };
}

class PriceRange {
  PriceRange({
    this.rangeName,
  });

  String? rangeName;

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        rangeName: json["range_name"],
      );

  Map<String, dynamic> toJson() => {
        "range_name": rangeName,
      };
}

class ProjStatus {
  ProjStatus({
    this.statName,
  });

  String? statName;

  factory ProjStatus.fromJson(Map<String, dynamic> json) => ProjStatus(
        statName: json["stat_name"],
      );

  Map<String, dynamic> toJson() => {
        "stat_name": statName,
      };
}

class SubCategory {
  SubCategory({
    this.name,
    this.category,
  });

  String? name;
  Category? category;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"],
        category: Category.fromJson(json["Category"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "Category": category!.toJson(),
      };
}

class Category {
  Category({
    this.catName,
    this.catImg,
  });

  String? catName;
  String? catImg;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        catName: json["cat_name"],
        catImg: json["cat_img"],
      );

  Map<String, dynamic> toJson() => {
        "cat_name": catName,
        "cat_img": catImg,
      };
}
