// To parse this JSON data, do
//
//     final notificationUnReadModel = notificationUnReadModelFromJson(jsonString);

import 'dart:convert';

NotificationUnReadModel notificationUnReadModelFromJson(String str) =>
    NotificationUnReadModel.fromJson(json.decode(str));

String notificationUnReadModelToJson(NotificationUnReadModel data) =>
    json.encode(data.toJson());

class NotificationUnReadModel {
  NotificationUnReadModel({
    required this.id,
    required this.email,
    required this.fullname,
    required this.phone,
    required this.imgPath,
    required this.unreadCount,
    required this.permissions,
  });

  final String id;
  final String email;
  final String fullname;
  final String phone;
  final String imgPath;
  final int unreadCount;
  final List<String> permissions;

  factory NotificationUnReadModel.fromJson(Map<String, dynamic> json) =>
      NotificationUnReadModel(
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        fullname: json["fullname"] ?? "",
        phone: json["phone"] ?? "",
        imgPath: json["imgPath"] ?? "",
        unreadCount: json["unreadCount"] ?? 0,
        permissions: List<String>.from(json["permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "fullname": fullname,
        "phone": phone,
        "imgPath": imgPath,
        "unreadCount": unreadCount,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
      };
}
