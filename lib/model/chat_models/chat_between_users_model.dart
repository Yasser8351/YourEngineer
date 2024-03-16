class ChatBetweenUsersModel {
  int? totalItems;
  List<ChatBetweenUsers>? results;
  int? totalPages;
  int? currentPage;

  ChatBetweenUsersModel(
      {this.totalItems, this.results, this.totalPages, this.currentPage});

  ChatBetweenUsersModel.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'] ?? 0;
    if (json['results'] != null) {
      results = <ChatBetweenUsers>[];
      json['results'].forEach((v) {
        results!.add(new ChatBetweenUsers.fromJson(v));
      });
    }
    totalPages = json['totalPages'] ?? 0;
    currentPage = json['currentPage'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class ChatBetweenUsers {
  String? senderId;
  String? receiverId;
  String? message;
  String? messageType;
  String? fileUrl;
  String? createdAt;
  String? sender_email;

  ChatBetweenUsers(
      {this.senderId,
      this.receiverId,
      this.message,
      this.messageType,
      this.fileUrl,
      this.sender_email,
      this.createdAt});

  ChatBetweenUsers.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'] ?? '';
    receiverId = json['receiver_id'] ?? '';
    message = json['message'] ?? '';
    messageType = json['message_type'] ?? '';
    sender_email = json['sender_email'] ?? '';
    fileUrl = json['fileUrl'] ?? '';
    createdAt = json['createdAt'] ?? '';
  }
  ChatBetweenUsers.fromJson2(Map<String, dynamic> json) {
    senderId = json['senderId'] ?? '';
    receiverId = json['receiverId'] ?? '';
    message = json['text'] ?? '';
    messageType = json['message_type'] ?? '';
    fileUrl = json['fileUrl'] ?? '';
    createdAt = json['time'] ?? '';
  }
  ChatBetweenUsers.fromJson3(Map<String, dynamic> json) {
    senderId = json['sender_id'] ?? '';
    receiverId = json['receiver_id'] ?? '';
    message = json['message'] ?? '';
    messageType = json['message_type'] ?? '';
    fileUrl = json['fileUrl'] ?? '';
    createdAt = json['createdAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['message'] = this.message;
    data['message_type'] = this.messageType;
    data['fileUrl'] = this.fileUrl;
    data['createdAt'] = this.createdAt;

    return data;
  }
}
