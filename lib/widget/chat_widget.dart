import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/utilits/helper.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../model/chat_models/last_chats_model.dart';
import 'shared_widgets/full_image.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.messageModel, this.userEmail = ''})
      : super(key: key);

  final Chats messageModel;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    var senderImg = ApiUrl.imageUrl + messageModel.senderImg;

    return ListTile(
      title: TextWidget(
          title: messageModel.senderName, fontSize: 14, color: Colors.black),
      subtitle: Row(
        children: [
          messageModel.senderEmail.contains(userEmail)
              ? Icon(Icons.done_all, color: Colors.green)
              : const SizedBox(),
          Container(
            height: Get.width * .1,
            width: Get.width * .31,
            child: Center(
              child: TextWidget(
                  title: messageModel.message,
                  textOverflow: TextOverflow.clip,
                  fontSize: 14,
                  color: Colors.black),
            ),
          ),
        ],
      ),
      trailing: Text(dateFormat(messageModel.createdAt)),
      leading: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FullImage(imageUrl: senderImg)));
        },
        child: CircleAvatar(
          radius: 30.0,
          // child: Image.network(senderImg),
          backgroundImage: NetworkImage(
            senderImg,
          ),
        ),
      ),
    );
  }
}
