// // To parse this JSON data, do
// //
// //     final projectModel = projectModelFromJson(jsonString);

// import 'dart:convert';

// List<ProModel?>? projectModelFromJson(String str) => json.decode(str) == null
//     ? []
//     : List<ProModel?>.from(json.decode(str)!.map((x) => ProModel.fromJson(x)));

// String projectModelToJson(List<ProModel?>? data) => json.encode(
//     data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

// class ProModel {
//   ProModel({
//     this.id,
//     this.userAddedId,
//     this.projTitle,
//     this.projDescription,
//     this.categoryId,
//     this.priceRangeId,
//     this.projPeriod,
//     this.projStatusId,
//     this.updatedAt,
//     this.createdAt,
//   });

//   String? id;
//   String? userAddedId;
//   String? projTitle;
//   String? projDescription;
//   String? categoryId;
//   String? priceRangeId;
//   String? projPeriod;
//   String? projStatusId;
//   String? updatedAt;
//   String? createdAt;

//   factory ProModel.fromJson(Map<String, dynamic> json) => ProModel(
//         id: json["id"] ?? '',
//         userAddedId: json["user_added_id"] ?? '',
//         projTitle: json["proj_title"] ?? '',
//         projDescription: json["proj_description"] ?? '',
//         categoryId: json["category_id"] ?? '',
//         priceRangeId: json["price_range_id"] ?? '',
//         projPeriod: json["proj_period"] ?? '',
//         projStatusId: json["proj_status_id"] ?? '',
//         updatedAt: json["updatedAt"] ?? '',
//         createdAt: json["createdAt"] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_added_id": userAddedId,
//         "proj_title": projTitle,
//         "proj_description": projDescription,
//         "category_id": categoryId,
//         "price_range_id": priceRangeId,
//         "proj_period": projPeriod,
//         "proj_status_id": projStatusId,
//         "updatedAt": updatedAt,
//         "createdAt": createdAt,
//       };
// }
