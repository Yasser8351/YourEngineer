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
    this.review_avg = '',
    required this.isActive,
    required this.userprofiles,
    required this.usercredentials,
    required this.userskills,
    required this.userportfolio,
    required this.wallet,
    required this.talentreview,
  });

  String id;
  String email;
  String fullname;
  String phone;
  String review_avg;
  String imgpath;
  bool isActive;
  Userprofiles userprofiles;
  Usercredentials usercredentials;
  List<Userskill?> userskills;
  List<Userportfolio?>? userportfolio;
  Wallet wallet;
  List<Talentreview> talentreview;

  // List<dynamic> talentreview;

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
        usercredentials: json["userprofiles"] == null
            ? Usercredentials()
            : Usercredentials.fromJson(json["usercredentials"]),
        userskills: List<Userskill?>.from(
            json["userskills"].map((x) => Userskill.fromJson(x))),
        userportfolio: json["userportfolio"] == null
            ? []
            : List<Userportfolio?>.from(
                json["userportfolio"]!.map((x) => Userportfolio.fromJson(x))),
        wallet: json["wallet"] == null
            ? Wallet(
                id: '', user_id: '', credit: '', createdAt: '', updatedAt: '')
            : Wallet.fromJson(json["wallet"]),
        talentreview: List.from(json['talentreview'])
            .map((e) => Talentreview.fromJson(e))
            .toList(),
      );

  // static double checkDouble(dynamic value) {
  //   if (value is String) {
  //     return double.parse(value);
  //   } else {
  //     return value;
  //   }
  // }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "fullname": fullname,
        "phone": phone,
        "imgpath": imgpath,
        "is_active": isActive,
        "userprofiles": userprofiles,
        "usercredentials": usercredentials.toJson(),
        "userskills": userskills == null
            ? []
            : List<dynamic>.from(userskills.map((x) => x!.toJson())),
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

class Wallet {
  Wallet({
    required this.id,
    required this.user_id,
    required this.credit,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String user_id;
  final String credit;
  final String createdAt;
  final String updatedAt;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"] ?? '',
        user_id: json["user_id"] ?? '',
        createdAt: json["createdAt"] ?? '',
        credit: json["credit"] ?? '0.0',
        updatedAt: json["updatedAt"] ?? '',
      );
}

class Talentreview {
  Talentreview({
    required this.comment,
    required this.starRate,
    required this.createdAt,
    required this.owner,
    required this.project,
  });
  late final String comment;
  late final String starRate;
  late final String createdAt;
  late final Owner owner;
  late final Project project;

  Talentreview.fromJson(Map<String, dynamic> json) {
    comment = json['comment'] ?? "";
    starRate = json['star_rate'].toString();
    createdAt = json['createdAt'] ?? "";
    owner = Owner.fromJson(json['owner']);
    project = Project.fromJson(json['Project']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['comment'] = comment;
    _data['star_rate'] = starRate;
    _data['createdAt'] = createdAt;
    _data['owner'] = owner.toJson();
    _data['Project'] = project.toJson();
    return _data;
  }
}

class Owner {
  Owner({
    required this.id,
    required this.email,
    required this.fullname,
    required this.phone,
    required this.imgpath,
  });
  late final String id;
  late final String email;
  late final String fullname;
  late final String phone;
  late final String imgpath;

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    email = json['email'] ?? "";
    fullname = json['fullname'] ?? "";
    phone = json['phone'] ?? "";
    imgpath = json['imgpath'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['fullname'] = fullname;
    _data['phone'] = phone;
    _data['imgpath'] = imgpath;
    return _data;
  }
}

class Project {
  Project({
    required this.projTitle,
    required this.projDescription,
    required this.projPeriod,
  });
  late final String projTitle;
  late final String projDescription;
  late final int projPeriod;

  Project.fromJson(Map<String, dynamic> json) {
    projTitle = json['proj_title'] ?? "";
    projDescription = json['proj_description'] ?? "";
    projPeriod = json['proj_period'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['proj_title'] = projTitle;
    _data['proj_description'] = projDescription;
    _data['proj_period'] = projPeriod;
    return _data;
  }
}
