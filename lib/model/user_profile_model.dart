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
    required this.id,
    required this.email,
    required this.fullname,
    required this.phone,
    required this.imgpath,
    required this.review_avg,
    required this.isActive,
    this.userprofiles,
    this.usercredentials,
    this.userskills,
    this.userportfolio,
  });

  String id;
  String email;
  String fullname;
  String phone;
  String review_avg;
  String imgpath;
  bool isActive;
  Userprofiles? userprofiles;
  Usercredentials? usercredentials;
  List<Userskill?>? userskills;
  List<Userportfolio?>? userportfolio;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        fullname: json["fullname"] ?? '',
        phone: json["phone"] ?? '',
        imgpath: json["imgpath"] ?? '',
        review_avg: json["review_avg"].toString(),
        isActive: json["is_active"] ?? false,
        userprofiles: json["userprofiles"] == null
            ? Userprofiles(aboutUser: '', specialization: '')
            : Userprofiles.fromJson(json["userprofiles"]),
        usercredentials:
            Usercredentials.fromJson(json["usercredentials"] ?? []),
        userskills: List<Userskill?>.from(
            json["userskills"].map((x) => Userskill.fromJson(x))),
        userportfolio: json["userportfolio"] == null
            ? []
            : List<Userportfolio?>.from(
                json["userportfolio"]!.map((x) => Userportfolio.fromJson(x))),
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
            : List<dynamic>.from(userskills!.map((x) => x!.toJson())),
        "userportfolio": userportfolio == null
            ? []
            : List<dynamic>.from(userportfolio!.map((x) => x!.toJson())),
      };
}

class Usercredentials {
  Usercredentials({
    this.attachments,
    this.isAuthorized = false,
  });

  dynamic attachments;
  bool isAuthorized;

  factory Usercredentials.fromJson(Map<String, dynamic> json) =>
      Usercredentials(
        attachments: json["attachments"] ?? '',
        isAuthorized: json["is_authorized"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "attachments": attachments,
        "is_authorized": isAuthorized,
      };
}

class Userportfolio {
  Userportfolio({
    this.title,
    this.description,
    required this.imgpath,
    this.urlLink,
    this.createdAt,
  });

  String? title;
  String? description;
  String imgpath;
  String? urlLink;
  String? createdAt;

  factory Userportfolio.fromJson(Map<String, dynamic> json) => Userportfolio(
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        imgpath: json["imgpath"] ?? '',
        urlLink: json["url_link"] ?? '',
        createdAt: json["createdAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "imgpath": imgpath,
        "url_link": urlLink,
        "createdAt": createdAt,
      };
}

class Userskill {
  Userskill({
    this.skillName,
  });

  String? skillName;

  factory Userskill.fromJson(Map<String, dynamic> json) => Userskill(
        skillName: json["skill_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "skill_name": skillName,
      };
}

class Userprofiles {
  Userprofiles({
    required this.aboutUser,
    required this.specialization,
  });

  final String aboutUser;
  final String specialization;

  factory Userprofiles.fromJson(Map<String, dynamic> json) => Userprofiles(
        aboutUser: json["about_user"] ?? '',
        specialization: json["specialization"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "about_user": aboutUser,
        "specialization": specialization,
      };
}
