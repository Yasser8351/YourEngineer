// // To parse required this JSON data, do
// //
// //     final projectModel = projectModelFromJson(jsonString);

// import 'dart:convert';

// ProjectModel projectModelFromJson(String str) => ProjectModel.fromJson(
//     json.decode(str)!.map((x) => ProjectModel.fromJson(x)));

// String projectModelToJson(ProjectModel? data) => json.encode(data!.toJson());

// ///
// ///
// // ProjectModel? projectModelFromJson(String str) => ProjectModel.fromJson(
// //     json.decode(str).map((x) => ProjectModel.fromJson(x)));

// // String projectModelToJson(ProjectModel? data) => json.encode(data!.toJson());

// class ProjectModel {
//   ProjectModel({
//     this.totalItems,
//     this.results,
//     this.totalPages,
//     this.currentPage,
//   });

//   int? totalItems;
//   List<Result> results;
//   int? totalPages;
//   int? currentPage;

//   factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
//         totalItems: json["totalItems"],
//         results:
//             List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
//         totalPages: json["totalPages"],
//         currentPage: json["currentPage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "totalItems": totalItems,
//         "results": results == null
//             ? []
//             : List<dynamic>.from(results!.map((x) => x!.toJson())),
//         "totalPages": totalPages,
//         "currentPage": currentPage,
//       };
// }

// class Result {
//   Result({
//     this.id,
//     this.projTitle,
//     this.projDescription,
//     this.skills,
//     this.projPeriod,
//     this.createdAt,
//     this.attatchmentFile,
//     this.offersCount,
//     this.owner,
//     this.subCategory,
//     this.priceRange,
//     this.projStatus,
//   });

//   String? id;
//   String? projTitle;
//   String? projDescription;
//   String? skills;
//   int? projPeriod;
//   String? createdAt;
//   String? attatchmentFile;
//   int? offersCount;
//   Owner? owner;
//   SubCategory? subCategory;
//   PriceRange? priceRange;
//   ProjStatus? projStatus;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"] ?? '',
//         projTitle: json["proj_title"] ?? '',
//         projDescription: json["proj_description"] ?? '',
//         skills: json["skills"] ?? '',
//         projPeriod: json["proj_period"] ?? '',
//         createdAt: json["CreatedAt"] ?? '',
//         attatchmentFile: json["attatchment_file"] ?? '',
//         offersCount: json["OffersCount"] ?? '',
//         owner: Owner.fromJson(json["owner"] ?? ''),
//         subCategory: SubCategory.fromJson(json["SubCategory"] ?? ''),
//         priceRange: PriceRange.fromJson(json["PriceRange"] ?? ''),
//         projStatus: ProjStatus.fromJson(json["ProjStatus"] ?? ''),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "proj_title": projTitle,
//         "proj_description": projDescription,
//         "skills": skills,
//         "proj_period": projPeriod,
//         "CreatedAt": createdAt,
//         "attatchment_file": attatchmentFile,
//         "OffersCount": offersCount,
//         "owner": owner!.toJson(),
//         "SubCategory": subCategory!.toJson(),
//         "PriceRange": priceRange!.toJson(),
//         "ProjStatus": projStatus!.toJson(),
//       };
// }

// class Owner {
//   Owner({
//     this.fullname,
//     this.avatar,
//   });

//   String? fullname;
//   String? avatar;

//   factory Owner.fromJson(Map<String, dynamic> json) => Owner(
//         fullname: json["fullname"],
//         avatar: json["avatar"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fullname": fullname,
//         "avatar": avatar,
//       };
// }

// class PriceRange {
//   PriceRange({
//     this.rangeName,
//   });

//   String? rangeName;

//   factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
//         rangeName: json["range_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "range_name": rangeName,
//       };
// }

// class ProjStatus {
//   ProjStatus({
//     this.statName,
//   });

//   String? statName;

//   factory ProjStatus.fromJson(Map<String, dynamic> json) => ProjStatus(
//         statName: json["stat_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "stat_name": statName,
//       };
// }

// class SubCategory {
//   SubCategory({
//     this.name,
//     this.category,
//   });

//   String? name;
//   Category? category;

//   factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
//         name: json["name"],
//         category: Category.fromJson(json["Category"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "Category": category!.toJson(),
//       };
// }

// class Category {
//   Category({
//     this.catName,
//     this.catImg,
//   });

//   String? catName;
//   String? catImg;

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         catName: json["cat_name"],
//         catImg: json["cat_img"],
//       );

//   Map<String, dynamic> toJson() => {
//         "cat_name": catName,
//         "cat_img": catImg,
//       };
// }

// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  ProjectModel({
    required this.totalItems,
    required this.results,
    required this.totalPages,
    required this.currentPage,
  });

  int totalItems;
  List<Result> results;
  int totalPages;
  int currentPage;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        totalItems: json["totalItems"] ?? 0,
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["totalPages"] ?? 0,
        currentPage: json["currentPage"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Result {
  Result({
    required this.id,
    required this.projTitle,
    required this.projDescription,
    required this.skills,
    required this.projPeriod,
    required this.createdAt,
    required this.attatchmentFile,
    required this.offersCount,
    required this.owner,
    required this.subCategory,
    required this.priceRange,
    required this.projStatus,
  });

  String id;
  String projTitle;
  String projDescription;
  String skills;
  int projPeriod;
  String createdAt;
  dynamic attatchmentFile;
  int offersCount;
  Owner owner;
  SubCategory subCategory;
  PriceRange priceRange;
  ProjStatus projStatus;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] ?? '',
        projTitle: json["proj_title"] ?? '',
        projDescription: json["proj_description"] ?? '',
        skills: json["skills"] ?? 0,
        projPeriod: json["proj_period"] ?? 0,
        createdAt: json["CreatedAt"] ?? '',
        attatchmentFile: json["attatchment_file"] ?? '',
        offersCount: json["OffersCount"] ?? 0,
        owner: Owner.fromJson(json["owner"]),
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
        "attatchment_file": attatchmentFile,
        "OffersCount": offersCount,
        "owner": owner.toJson(),
        "SubCategory": subCategory.toJson(),
        "PriceRange": priceRange.toJson(),
        "ProjStatus": projStatus.toJson(),
      };
}

class Owner {
  Owner({
    required this.fullname,
    required this.avatar,
  });

  String fullname;
  String avatar;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        fullname: json["fullname"] ?? '',
        avatar: json["avatar"] ?? '',
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

  String rangeName;

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        rangeName: json["range_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "range_name": rangeName,
      };
}

class ProjStatus {
  ProjStatus({
    required this.statName,
  });

  String statName;

  factory ProjStatus.fromJson(Map<String, dynamic> json) => ProjStatus(
        statName: json["stat_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "stat_name": statName,
      };
}

enum StatName { OPEN }

class SubCategory {
  SubCategory({
    required this.name,
    required this.category,
  });

  String name;
  Category category;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"] ?? '',
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

  String catName;
  String catImg;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        catName: json["cat_name"] ?? '',
        catImg: json["cat_img"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "cat_name": catName,
        "cat_img": catImg,
      };
}
