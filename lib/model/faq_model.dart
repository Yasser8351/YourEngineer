// To parse this JSON data, do
//
//     final faqtModel = faqtModelFromJson(jsonString);

import 'dart:convert';

List<FaqtModel> faqtModelFromJson(String str) =>
    List<FaqtModel>.from(json.decode(str)!.map((x) => FaqtModel.fromJson(x)));

String faqtModelToJson(List<FaqtModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqtModel {
  FaqtModel({
    this.id,
    this.question,
    this.answer,
    this.orderNo,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? question;
  String? answer;
  int? orderNo;
  String? createdAt;
  String? updatedAt;

  factory FaqtModel.fromJson(Map<String, dynamic> json) => FaqtModel(
        id: json["id"] ?? '',
        question: json["question"] ?? '',
        answer: json["answer"],
        orderNo: json["order_no"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "order_no": orderNo,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
