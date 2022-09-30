import 'sub_services_model.dart';

import 'dart:convert';

// class PopulerServicesModel {
//   String titleServices;
//   String imageUrlServices;
//   List<SubServicesModel> listSubServices;

//   PopulerServicesModel(
//       {required this.titleServices,
//       required this.imageUrlServices,
//       required this.listSubServices});
// }

// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

List<PopulerServicesModel> categoryModelFromJson(String str) =>
    List<PopulerServicesModel>.from(
        json.decode(str).map((x) => PopulerServicesModel.fromJson(x)));

String categoryModelToJson(List<PopulerServicesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopulerServicesModel {
  PopulerServicesModel({
    required this.id,
    required this.titleServices,
    required this.imageUrlServices,
    required this.catDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String titleServices;
  String imageUrlServices;
  String catDescription;
  String createdAt;
  String updatedAt;

  factory PopulerServicesModel.fromJson(Map<String, dynamic> json) =>
      PopulerServicesModel(
        id: json["id"] ?? '',
        titleServices: json["cat_name"] ?? '',
        imageUrlServices: json["cat_img"] ?? '',
        catDescription: json["cat_description"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_name": titleServices,
        "cat_img": imageUrlServices,
        "cat_description": catDescription,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
