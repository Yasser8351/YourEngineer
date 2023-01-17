// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    this.id,
    this.email,
    this.fullname,
    this.phone,
    this.imgpath,
    this.isActive,
    this.userprofiles,
    this.usercredentials,
    this.userskills,
    this.userportfolio,
  });

  String? id;
  String? email;
  String? fullname;
  String? phone;
  dynamic imgpath;
  bool? isActive;
  dynamic userprofiles;
  Usercredentials? usercredentials;
  List<dynamic>? userskills;
  List<dynamic>? userportfolio;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        fullname: json["fullname"] ?? '',
        phone: json["phone"] ?? '',
        imgpath: json["imgpath"] ?? '',
        isActive: json["is_active"] ?? '',
        userprofiles: json["userprofiles"] ?? '',
        usercredentials: Usercredentials.fromJson(json["usercredentials"]),
        userskills: json["userskills"] == null
            ? []
            : List<dynamic>.from(json["userskills"]!.map((x) => x)),
        userportfolio: json["userportfolio"] == null
            ? []
            : List<dynamic>.from(json["userportfolio"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "fullname": fullname,
        "phone": phone,
        "imgpath": imgpath,
        "is_active": isActive,
        "userprofiles": userprofiles,
        "usercredentials": usercredentials!.toJson(),
        "userskills": userskills == null
            ? []
            : List<dynamic>.from(userskills!.map((x) => x)),
        "userportfolio": userportfolio == null
            ? []
            : List<dynamic>.from(userportfolio!.map((x) => x)),
      };
}

class Usercredentials {
  Usercredentials({
    this.attachments,
    this.isAuthorized,
  });

  dynamic attachments;
  bool? isAuthorized;

  factory Usercredentials.fromJson(Map<String, dynamic> json) =>
      Usercredentials(
        attachments: json["attachments"],
        isAuthorized: json["is_authorized"],
      );

  Map<String, dynamic> toJson() => {
        "attachments": attachments,
        "is_authorized": isAuthorized,
      };
}
