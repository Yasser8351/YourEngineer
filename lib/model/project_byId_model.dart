// To parse this JSON data, do
//
//     final projectByIdModel = projectByIdModelFromJson(jsonString);

import 'dart:convert';

ProjectByIdModel projectByIdModelFromJson(String str) =>
    ProjectByIdModel.fromJson(json.decode(str));

String projectByIdModelToJson(ProjectByIdModel data) =>
    json.encode(data.toJson());

class ProjectByIdModel {
  ProjectByIdModel({
    required this.id,
    required this.projTitle,
    required this.projDescription,
    required this.skills,
    required this.projPeriod,
    required this.createdAt,
    required this.attatchmentFile,
    required this.userOfferCount,
    required this.isProjectOwner,
    required this.offersCount,
    required this.ratePercent,
    required this.owner,
    required this.subCategory,
    required this.priceRange,
    required this.projStatus,
    required this.projectoffers,
  });

  final String id;
  final String projTitle;
  final String projDescription;
  final String skills;
  final int projPeriod;
  final DateTime createdAt;
  final dynamic attatchmentFile;
  final int userOfferCount;
  final int isProjectOwner;
  final int offersCount;
  final double ratePercent;
  final Owner owner;
  final SubCategory subCategory;
  final PriceRange priceRange;
  final ProjStatus projStatus;
  final List<dynamic> projectoffers;

  factory ProjectByIdModel.fromJson(Map<String, dynamic> json) =>
      ProjectByIdModel(
        id: json["id"],
        projTitle: json["proj_title"],
        projDescription: json["proj_description"],
        skills: json["skills"],
        projPeriod: json["proj_period"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        attatchmentFile: json["attatchment_file"],
        userOfferCount: json["UserOfferCount"],
        isProjectOwner: json["IsProjectOwner"],
        offersCount: json["OffersCount"],
        ratePercent: json["rate_percent"].toDouble(),
        owner: Owner.fromJson(json["owner"]),
        subCategory: SubCategory.fromJson(json["SubCategory"]),
        priceRange: PriceRange.fromJson(json["PriceRange"]),
        projStatus: ProjStatus.fromJson(json["ProjStatus"]),
        projectoffers: List<dynamic>.from(json["projectoffers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "proj_title": projTitle,
        "proj_description": projDescription,
        "skills": skills,
        "proj_period": projPeriod,
        "CreatedAt": createdAt.toIso8601String(),
        "attatchment_file": attatchmentFile,
        "UserOfferCount": userOfferCount,
        "IsProjectOwner": isProjectOwner,
        "OffersCount": offersCount,
        "rate_percent": ratePercent,
        "owner": owner.toJson(),
        "SubCategory": subCategory.toJson(),
        "PriceRange": priceRange.toJson(),
        "ProjStatus": projStatus.toJson(),
        "projectoffers": List<dynamic>.from(projectoffers.map((x) => x)),
      };
}

class Owner {
  Owner({
    required this.fullname,
    required this.avatar,
  });

  final String fullname;
  final dynamic avatar;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        fullname: json["fullname"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "avatar": avatar,
      };
}

class PriceRange {
  PriceRange({
    required this.rangeName,
  });

  final String rangeName;

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        rangeName: json["range_name"],
      );

  Map<String, dynamic> toJson() => {
        "range_name": rangeName,
      };
}

class ProjStatus {
  ProjStatus({
    required this.statName,
  });

  final String statName;

  factory ProjStatus.fromJson(Map<String, dynamic> json) => ProjStatus(
        statName: json["stat_name"],
      );

  Map<String, dynamic> toJson() => {
        "stat_name": statName,
      };
}

class SubCategory {
  SubCategory({
    required this.name,
    required this.category,
  });

  final String name;
  final Category category;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"],
        category: Category.fromJson(json["Category"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "Category": category.toJson(),
      };
}

class Category {
  Category({
    required this.catName,
    required this.catImg,
  });

  final String catName;
  final String catImg;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        catName: json["cat_name"],
        catImg: json["cat_img"],
      );

  Map<String, dynamic> toJson() => {
        "cat_name": catName,
        "cat_img": catImg,
      };
}
