import 'package:flutter/material.dart';
import 'package:your_engineer/model/message_model.dart';
import 'package:your_engineer/screen/support_chat_screen.dart';

import '../app_config/app_image.dart';
import '../widget/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageModel> listChat = [
    MessageModel(
        name: "Ahmed Ali",
        message: "Hi",
        imgeUrl: AppImage.img11,
        messageTime: "01:22 PM"),
    MessageModel(
        name: "Yasser Osman",
        message: "are you ok?",
        imgeUrl: AppImage.img12,
        messageTime: "11:00 AM"),
    MessageModel(
        name: "Abubaker Khalid",
        message: "how are you",
        imgeUrl: AppImage.img9,
        messageTime: "02:09 PM"),
    MessageModel(
        name: "Mohammed Nasir",
        message: "Ok i,will",
        imgeUrl: AppImage.img8,
        messageTime: "12:09 AM"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // child: NoData(
        //   textMessage: AppConfig.noMessageYet,
        //   imageUrlAssets: AppImage.noData,
        //   onTap: (() {}),
        // ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              shrinkWrap: true,
              itemCount: listChat.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SupportChatScreen(
                              imageUrl: listChat[index].imgeUrl,
                              name: listChat[index].name,
                            )));
                    // Navigator.of(context).pushNamed(AppConfig.chatRoom);
                  },
                  child: ChatWidget(
                    messageModel: listChat[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
