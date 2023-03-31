import 'package:flutter/material.dart';
import 'package:your_engineer/utilits/helper.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../model/chat_models/last_chats_model.dart';
import 'shared_widgets/full_image.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.messageModel}) : super(key: key);

  final Chats messageModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextWidget(
          title: messageModel.recieverName,
          // textOverflow: TextOverflow.ellipsis,
          fontSize: 14,
          color: Colors.black),
      subtitle: Container(
        height: 10,
        child: TextWidget(
            title: messageModel.message,
            textOverflow: TextOverflow.ellipsis,
            fontSize: 14,
            color: Colors.black),
      ),
      trailing: Text(dateFormat(messageModel.createdAt)),
      leading: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  FullImage(imageUrl: messageModel.senderImg)));
        },
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage(
            messageModel.senderImg,
          ),
        ),
      ),
    );
  }
}
