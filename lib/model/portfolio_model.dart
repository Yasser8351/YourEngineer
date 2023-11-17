// To parse this JSON data, do
//
//     final portfolioModel = portfolioModelFromJson(jsonString);

// List<PortfolioModel> portfolioModelFromJson(String str) =>
//     List<PortfolioModel>.from(
//         json.decode(str).map((x) => PortfolioModel.fromJson(x)));

// String portfolioModelToJson(List<PortfolioModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PortfolioModel {
  PortfolioModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgpath,
    required this.urlLink,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String imgpath;
  final String urlLink;
  final String createdAt;

  factory PortfolioModel.fromJson(Map<String, dynamic> json) => PortfolioModel(
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        imgpath: json["imgpath"] ?? '',
        urlLink: json["url_link"] ?? '',
        createdAt: json["createdAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "imgpath": imgpath,
        "url_link": urlLink,
        "createdAt": createdAt,
      };
}
