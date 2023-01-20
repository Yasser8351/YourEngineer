import 'package:flutter/material.dart';
import 'package:your_engineer/model/message_model.dart';
import 'package:your_engineer/screen/chat/chat_room_screen.dart';

import '../../app_config/app_image.dart';
import '../../widget/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageModel> listChat = [
    MessageModel(
        name: "rasheed@g1.com",
        message: "Hi",
        imgeUrl: AppImage.img11,
        messageTime: "01:22 PM"),
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
                      builder: (context) => ChatRoomScreen(
                          // receiverName: 'rasheed@g1.com',
                          ),
                    ));
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
