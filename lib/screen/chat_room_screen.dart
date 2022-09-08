import 'package:flutter/material.dart';

import 'package:your_engineer/model/message_model.dart';
import 'package:your_engineer/widget/chat_room_widget.dart';

import '../app_config/app_image.dart';
import '../widget/text_widget.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
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
      appBar: _getAppBar(context, 'Ahmed Ali'),
      body: SingleChildScrollView(
        // child: NoData(
        //   textMessage: AppConfig.noMessageYet,
        //   imageUrlAssets: AppImage.noData,
        //   onTap: (() {}),
        // ),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: listChat.length,
                itemBuilder: (context, index) {
                  return ChatRoomWidget(
                    messageModel: listChat[index],
                  );
                }),
          ],
        ),
      ),
    );
  }
}

_getAppBar(BuildContext context, String recevierName) {
  return AppBar(
    title: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextWidget(title: recevierName, fontSize: 18, color: Colors.white),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.navigate_before, size: 40),
      color: Colors.white,
    ),
  );
}
