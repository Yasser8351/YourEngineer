class MessageModel {
  String name;
  String message;
  String imgeUrl;
  String messageTime;
  bool isSender;

  MessageModel(
      {this.isSender = false,
      required this.name,
      required this.message,
      required this.imgeUrl,
      required this.messageTime});
}
/*
'receiverId',
 'senderId',
'text',
  'time',
*/