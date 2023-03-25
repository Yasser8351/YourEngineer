// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) =>
    PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) =>
    json.encode(data.toJson());

class PrivacyPolicyModel {
  PrivacyPolicyModel({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String description;
  final String createdAt;
  final String updatedAt;

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyModel(
        id: json["id"] ?? '',
        description: json["description"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
