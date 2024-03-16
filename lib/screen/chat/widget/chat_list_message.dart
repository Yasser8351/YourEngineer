import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/model/chat_models/chat_between_users_model.dart';
import 'package:your_engineer/screen/chat/widget/text_form_send_message.dart';

class ChatListMessage extends StatelessWidget {
  const ChatListMessage({
    super.key,
    required this.listChatBetweenUsers,
    required this.receiverId,
    required this.onTapSendMessage,
    required this.messageController,
  });

  final List<ChatBetweenUsers> listChatBetweenUsers;
  final String receiverId;
  final Function() onTapSendMessage;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: listChatBetweenUsers.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10, bottom: Get.height * .08),
          itemBuilder: (context, index) {
            return Container(
              padding:
                  EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
              child: Align(
                alignment:
                    (listChatBetweenUsers[index].senderId!.contains(receiverId)
                        ? Alignment.topRight
                        : Alignment.topLeft),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (listChatBetweenUsers[index]
                            .senderId!
                            .contains(receiverId)
                        ? Colors.green.shade200
                        : Colors.grey.shade200),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    listChatBetweenUsers[index].message!,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
          },
        ),
        TextFormSendMessage(
            onTapSendMessage: onTapSendMessage,
            messageController: messageController),
      ],
    );
  }
}
