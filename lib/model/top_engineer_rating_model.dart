/*
class TopEngineerRatingModel {
  String engineerName;
  String engineerspecialist;
  String imageUrl;
  double engineerRating;

  TopEngineerRatingModel({
    required this.engineerName,
    required this.engineerspecialist,
    required this.imageUrl,
    required this.engineerRating,
  });
}
*/

// To parse this JSON data, do
//
//     final topEngineerRatingModel = topEngineerRatingModelFromJson(jsonString);

import 'dart:convert';

List<TopEngineerRatingModel> topEngineerRatingModelFromJson(String str) =>
    List<TopEngineerRatingModel>.from(
        json.decode(str).map((x) => TopEngineerRatingModel.fromJson(x)));

String topEngineerRatingModelToJson(List<TopEngineerRatingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopEngineerRatingModel {
  TopEngineerRatingModel({
    required this.aboutUser,
    required this.specialization,
    required this.user,
  });

  String aboutUser;
  String specialization;
  User user;

  factory TopEngineerRatingModel.fromJson(Map<String, dynamic> json) =>
      TopEngineerRatingModel(
        aboutUser: json["about_user"] ?? '',
        specialization: json["specialization"] ?? '',
        user: User.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "about_user": aboutUser,
        "specialization": specialization,
        "User": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.email,
    required this.fullname,
    required this.phone,
    required this.imgPath,
  });

  String id;
  String email;
  String fullname;
  String phone;
  String imgPath;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        fullname: json["fullname"] ?? '',
        phone: json["phone"] ?? '',
        imgPath: json["imgPath"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "fullname": fullname,
        "phone": phone,
        "imgPath": imgPath,
      };
}
