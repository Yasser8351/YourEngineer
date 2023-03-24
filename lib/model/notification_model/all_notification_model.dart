// To parse this JSON data, do
//
//     final allNotificationModel = allNotificationModelFromJson(jsonString);

import 'dart:convert';

AllNotificationModel allNotificationModelFromJson(String str) =>
    AllNotificationModel.fromJson(json.decode(str));

String allNotificationModelToJson(AllNotificationModel data) =>
    json.encode(data.toJson());

class AllNotificationModel {
  AllNotificationModel({
    required this.totalItems,
    required this.results,
    required this.totalPages,
    required this.currentPage,
  });

  final int totalItems;
  final List<Result> results;
  final int totalPages;
  final int currentPage;

  factory AllNotificationModel.fromJson(Map<String, dynamic> json) =>
      AllNotificationModel(
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
    required this.title,
    required this.description,
    required this.type,
    required this.senderId,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.fullname,
    required this.imgPath,
    required this.roleName,
    required this.read,
    required this.receiverId,
  });

  final String id;
  final String title;
  final String description;
  final String type;
  final String senderId;
  final String createdAt;
  final String updatedAt;
  final String email;
  final String fullname;
  final String imgPath;
  final String roleName;
  final int read;
  final String receiverId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        type: json["type"] ?? '',
        senderId: json["sender_id"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        email: json["email"] ?? '',
        fullname: json["fullname"] ?? '',
        imgPath: json["imgPath"] ?? '',
        roleName: json["role_name"] ?? '',
        read: json["read"] ?? 0,
        receiverId: json["receiver_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "type": type,
        "sender_id": senderId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "email": email,
        "fullname": fullname,
        "imgPath": imgPath,
        "role_name": roleName,
        "read": read,
        "receiver_id": receiverId,
      };
}
