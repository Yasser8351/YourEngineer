// To parse this JSON data, do
//
//     final lastchatsModel = lastchatsModelFromJson(jsonString);

import 'dart:convert';

LastchatsModel lastchatsModelFromJson(String str) =>
    LastchatsModel.fromJson(json.decode(str));

String lastchatsModelToJson(LastchatsModel data) => json.encode(data.toJson());

class LastchatsModel {
  LastchatsModel({
    required this.totalItems,
    required this.results,
    required this.totalPages,
    required this.currentPage,
  });

  final int totalItems;
  final List<Chats> results;
  final int totalPages;
  final int currentPage;

  factory LastchatsModel.fromJson(Map<String, dynamic> json) => LastchatsModel(
        totalItems: json["totalItems"] ?? 0,
        results:
            List<Chats>.from(json["results"].map((x) => Chats.fromJson(x))),
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

class Chats {
  Chats({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.messageType,
    required this.senderEmail,
    required this.senderName,
    required this.senderImg,
    required this.recieverEmail,
    required this.recieverName,
    required this.recieverImg,
    required this.seqnum,
  });

  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final String createdAt;
  final String updatedAt;
  final String messageType;
  final String senderEmail;
  final String senderName;
  final String senderImg;
  final String recieverEmail;
  final String recieverName;
  final String recieverImg;
  final int seqnum;

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        id: json["id"] ?? '',
        senderId: json["sender_id"] ?? '',
        receiverId: json["receiver_id"] ?? '',
        message: json["message"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        messageType: json["message_type"] ?? '',
        senderEmail: json["sender_email"] ?? '',
        senderName: json["sender_name"] ?? '',
        senderImg: json["sender_img"] ?? '',
        recieverEmail: json["receiver_email"] ?? '',
        recieverName: json["receiver_name"] ?? '',
        recieverImg: json["reciever_img"] ?? '',
        seqnum: json["seqnum"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "message_type": messageType,
        "sender_email": senderEmail,
        "sender_name": senderName,
        "sender_img": senderImg,
        "reciever_email": recieverEmail,
        "reciever_name": recieverName,
        "reciever_img": recieverImg,
        "seqnum": seqnum,
      };
}
