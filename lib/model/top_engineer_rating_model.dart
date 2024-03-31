// To parse this JSON data, do
//
//     final topEngineerRatingModel = topEngineerRatingModelFromJson(jsonString);

import 'dart:convert';

TopEngineerRatingModel topEngineerRatingModelFromJson(String str) =>
    TopEngineerRatingModel.fromJson(json.decode(str));

String topEngineerRatingModelToJson(TopEngineerRatingModel? data) =>
    json.encode(data!.toJson());

// List<TopEngineerRatingModel> topEngineerRatingModelFromJson(String str) =>
//     List<TopEngineerRatingModel>.from(
//         json.decode(str)!.map((x) => TopEngineerRatingModel.fromJson(x)));

// String topEngineerRatingModelToJson(List<TopEngineerRatingModel> data) =>
//     json.encode(
//         data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class TopEngineerRatingModel {
  TopEngineerRatingModel({
    this.totalItems,
    required this.results,
    this.totalPages,
    this.currentPage,
  });

  int? totalItems;
  List<Result> results;
  int? totalPages;
  int? currentPage;

  factory TopEngineerRatingModel.fromJson(Map<String, dynamic> json) =>
      TopEngineerRatingModel(
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
    required this.roleId,
    required this.email,
    required this.password,
    required this.fullname,
    required this.phone,
    required this.imgPath,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = 0,
    this.review_avg = 0,
  });

  String id;
  String roleId;
  String email;
  String password;
  String fullname;
  String phone;
  String imgPath;
  String createdAt;
  String updatedAt;
  int isActive;
  double review_avg;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] ?? '',
        roleId: json["role_id"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        fullname: json["fullname"] ?? '',
        phone: json["phone"] ?? '',
        imgPath: json["imgPath"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        isActive: json["is_active"] ?? 0,
        review_avg: json["review_avg"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "email": email,
        "password": password,
        "fullname": fullname,
        "phone": phone,
        "imgPath": imgPath,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "is_active": isActive,
      };
}
