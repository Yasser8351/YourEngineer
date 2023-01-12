import 'dart:convert';

List<RolesModel> rolesModelFromJson(String str) =>
    List<RolesModel>.from(json.decode(str)!.map((x) => RolesModel.fromJson(x)));

String rolesModelToJson(List<RolesModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class RolesModel {
  RolesModel({
    this.id,
    this.roleName,
    this.roleDescription,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? roleName;
  String? roleDescription;
  String? createdAt;
  String? updatedAt;

  factory RolesModel.fromJson(Map<String, dynamic> json) => RolesModel(
        id: json["id"] ?? '',
        roleName: json["role_name"] ?? '',
        roleDescription: json["role_description"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_name": roleName,
        "role_description": roleDescription,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
