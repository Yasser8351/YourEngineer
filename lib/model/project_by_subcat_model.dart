// // class ProjectBySubCatModel {
// //   late int totalItems;
// //   late List<Results> results;
// //   late int totalPages;
// //   late int currentPage;

// //   ProjectBySubCatModel(
// //       {required this.totalItems,
// //       required this.results,
// //       required this.totalPages,
// //       required this.currentPage});

// //   ProjectBySubCatModel.fromJson(Map<String, dynamic> json) {
// //     totalItems = json['totalItems'];
// //     if (json['results'] != null) {
// //       results = <Results>[];
// //       json['results'].forEach((v) {
// //         results.add(new Results.fromJson(v));
// //       });
// //     }
// //     totalPages = json['totalPages'];
// //     currentPage = json['currentPage'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['totalItems'] = this.totalItems;
// //     if (this.results != null) {
// //       data['results'] = this.results.map((v) => v.toJson()).toList();
// //     }
// //     data['totalPages'] = this.totalPages;
// //     data['currentPage'] = this.currentPage;
// //     return data;
// //   }
// // }

// // class Results {
// //   late String id;
// //   late String projTitle;
// //   late String projDescription;
// //   late String skills;
// //   late int projPeriod;
// //   late String createdAt;
// //   late dynamic attatchmentFile;
// //   late int offersCount;
// //   late Owner owner;
// //   late SubCategory subCategory;
// //   late PriceRange priceRange;
// //   late ProjStatus projStatus;

// //   Results(
// //       {required this.id,
// //       required this.projTitle,
// //       required this.projDescription,
// //       required this.skills,
// //       required this.projPeriod,
// //       required this.createdAt,
// //       required this.attatchmentFile,
// //       required this.offersCount,
// //       required this.owner,
// //       required this.subCategory,
// //       required this.priceRange,
// //       required this.projStatus});

// //   Results.fromJson(Map<String, dynamic> json) {
// //     id = json['id'] ?? '';
// //     projTitle = json['proj_title'] ?? '';
// //     projDescription = json['proj_description'] ?? '';
// //     skills = json['skills'] ?? '';
// //     projPeriod = json['proj_period'] ?? '';
// //     createdAt = json['CreatedAt'] ?? '';
// //     attatchmentFile = json['attatchment_file'] ?? '';
// //     offersCount = json['OffersCount'] ?? '';
// //     Owner.fromJson(json['owner']);
// //     priceRange = PriceRange.fromJson(json['PriceRange']);
// //     projStatus = ProjStatus.fromJson(json['ProjStatus']);
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['proj_title'] = this.projTitle;
// //     data['proj_description'] = this.projDescription;
// //     data['skills'] = this.skills;
// //     data['proj_period'] = this.projPeriod;
// //     data['CreatedAt'] = this.createdAt;
// //     data['attatchment_file'] = this.attatchmentFile;
// //     data['OffersCount'] = this.offersCount;
// //     if (this.owner != null) {
// //       data['owner'] = this.owner.toJson();
// //     }
// //     if (this.subCategory != null) {
// //       data['SubCategory'] = this.subCategory.toJson();
// //     }
// //     if (this.priceRange != null) {
// //       data['PriceRange'] = this.priceRange.toJson();
// //     }
// //     if (this.projStatus != null) {
// //       data['ProjStatus'] = this.projStatus.toJson();
// //     }
// //     return data;
// //   }
// // }

// // class Owner {
// //   late String fullname;
// //   late String avatar;

// //   Owner({required this.fullname, required this.avatar});

// //   Owner.fromJson(Map<String, dynamic> json) {
// //     fullname = json['fullname'] ?? '';
// //     avatar = json['avatar'] ?? '';
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['fullname'] = this.fullname;
// //     data['avatar'] = this.avatar;
// //     return data;
// //   }
// // }

// // class SubCategory {
// //   late String name;
// //   late Category category;

// //   SubCategory({required this.name, required this.category});

// //   SubCategory.fromJson(Map<String, dynamic> json) {
// //     name = json['name'] ?? '';
// //     category = Category.fromJson(json['Category']);
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['name'] = this.name;
// //     if (this.category != null) {
// //       data['Category'] = this.category.toJson();
// //     }
// //     return data;
// //   }
// // }

// // class Category {
// //   late String catName;
// //   late String catImg;

// //   Category({required this.catName, required this.catImg});

// //   Category.fromJson(Map<String, dynamic> json) {
// //     catName = json['cat_name'] ?? '';
// //     catImg = json['cat_img'] ?? '';
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['cat_name'] = this.catName;
// //     data['cat_img'] = this.catImg;
// //     return data;
// //   }
// // }

// // class PriceRange {
// //   late String rangeName;

// //   PriceRange({required this.rangeName});

// //   PriceRange.fromJson(Map<String, dynamic> json) {
// //     rangeName = json['range_name'] ?? '';
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['range_name'] = this.rangeName;
// //     return data;
// //   }
// // }

// // class ProjStatus {
// //   late String statName;

// //   ProjStatus({required this.statName});

// //   ProjStatus.fromJson(Map<String, dynamic> json) {
// //     statName = json['stat_name'] ?? '';
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['stat_name'] = this.statName;
// //     return data;
// //   }
// // }
// // To parse this JSON data, do
// //
// //     final projectBySubCatModel = projectBySubCatModelFromJson(jsonString);

// import 'dart:convert';

// ProjectBySubCatModel projectBySubCatModelFromJson(String str) =>
//     ProjectBySubCatModel.fromJson(json.decode(str));

// String projectBySubCatModelToJson(ProjectBySubCatModel data) =>
//     json.encode(data!.toJson());

// class ProjectBySubCatModel {
//   ProjectBySubCatModel({
//     this.totalItems,
//     required this.results,
//     this.totalPages,
//     this.currentPage,
//   });

//   int? totalItems;
//   List<dynamic> results;
//   int? totalPages;
//   int? currentPage;

//   factory ProjectBySubCatModel.fromJson(Map<String, dynamic> json) =>
//       ProjectBySubCatModel(
//         totalItems: json["totalItems"],
//         results:
//             List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
//         totalPages: json["totalPages"],
//         currentPage: json["currentPage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "totalItems": totalItems,
//         "results": List<dynamic>.from(results.map((x) => x!.toJson())),
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
//   DateTime? createdAt;
//   dynamic attatchmentFile;
//   int? offersCount;
//   Owner? owner;
//   SubCategory? subCategory;
//   PriceRange? priceRange;
//   ProjStatus? projStatus;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"],
//         projTitle: json["proj_title"],
//         projDescription: json["proj_description"],
//         skills: json["skills"],
//         projPeriod: json["proj_period"],
//         createdAt: DateTime.parse(json["CreatedAt"]),
//         attatchmentFile: json["attatchment_file"],
//         offersCount: json["OffersCount"],
//         owner: Owner.fromJson(json["owner"]),
//         subCategory: SubCategory.fromJson(json["SubCategory"]),
//         priceRange: PriceRange.fromJson(json["PriceRange"]),
//         projStatus: ProjStatus.fromJson(json["ProjStatus"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "proj_title": projTitle,
//         "proj_description": projDescription,
//         "skills": skills,
//         "proj_period": projPeriod,
//         "CreatedAt": createdAt?.toIso8601String(),
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
