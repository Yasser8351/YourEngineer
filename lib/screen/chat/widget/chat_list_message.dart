import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:your_engineer/model/chat_models/chat_between_users_model.dart';
import 'package:your_engineer/screen/chat/widget/text_form_send_message.dart';
import 'package:your_engineer/widget/shared_widgets/full_image.dart';
import 'package:your_engineer/widget/shared_widgets/image_network.dart';

class ChatListMessage extends StatelessWidget {
  const ChatListMessage({
    super.key,
    required this.listChatBetweenUsers,
    required this.receiverId,
    required this.onTapSendMessage,
    required this.messageController,
    required this.controller,
  });

  final List<ChatBetweenUsers> listChatBetweenUsers;
  final ScrollController controller;
  final String receiverId;
  final Function() onTapSendMessage;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: controller,
          itemCount: listChatBetweenUsers.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10, bottom: Get.height * .08),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 0),
                  child: Align(
                    alignment: (listChatBetweenUsers[index]
                            .senderId!
                            .contains(receiverId)
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
                      child: listChatBetweenUsers[index]
                              .messageType!
                              .contains("file")
                          ? ImageCached(
                              image: listChatBetweenUsers[index].fileUrl!,
                              width: Get.size.width * .5,
                              height: Get.size.height * .2,
                              onTap: () => Get.to(() => FullImage(
                                  imageUrl:
                                      listChatBetweenUsers[index].fileUrl!)),
                              fit: BoxFit.cover,
                            )
                          : Text(
                              listChatBetweenUsers[index].message!,
                              style: TextStyle(fontSize: 15),
                            ),
                    ),
                  ),
                ),
                Align(
                  alignment: (listChatBetweenUsers[index]
                          .senderId!
                          .contains(receiverId)
                      ? AlignmentDirectional.centerStart
                      : AlignmentDirectional.centerEnd),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: (listChatBetweenUsers[index]
                                .senderId!
                                .contains(receiverId)
                            ? Get.size.width * .03
                            : 0),
                        end: (listChatBetweenUsers[index]
                                .senderId!
                                .contains(receiverId)
                            ? 0
                            : Get.size.width * .03)),
                    child: Text(
                      GetTimeAgo.parse(
                          DateTime.parse(
                              listChatBetweenUsers[index].createdAt!),
                          pattern: "dd-MM-yyyy hh:mm aa",
                          locale: 'ar'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 40),
        TextFormSendMessage(
            onTapSendMessage: onTapSendMessage,
            messageController: messageController),
      ],
    );
  }
}
