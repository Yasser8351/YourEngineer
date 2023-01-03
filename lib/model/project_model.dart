// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  ProjectModel({
    required this.totalItems,
    required this.results,
    required this.totalPages,
    required this.currentPage,
  });

  int totalItems;
  List<Project> results;
  int totalPages;
  int currentPage;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        totalItems: json["totalItems"] ?? 0,
        results: List<Project>.from(json["results"].map((x) => x)),
        totalPages: json["totalPages"] ?? 0,
        currentPage: json["currentPage"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "results": List<dynamic>.from(results.map((x) => x)),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Project {
  String titleProject;
  String categoryProject;
  String descriptionProject;
  String postBy;
  String numberOfoffers;
  String createdDate;

  Project({
    required this.titleProject,
    required this.categoryProject,
    required this.descriptionProject,
    required this.postBy,
    required this.createdDate,
    required this.numberOfoffers,
  });
}
