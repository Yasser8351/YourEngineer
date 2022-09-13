import 'package:flutter/material.dart';

import '../model/message_model.dart';
import 'shared_widgets/full_image.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.messageModel}) : super(key: key);

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(messageModel.name),
      subtitle: Text(messageModel.message),
      trailing: Text(messageModel.messageTime),
      leading: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FullImage(imageUrl: messageModel.imgeUrl)));
        },
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage(
            messageModel.imgeUrl,
          ),
        ),
      ),
    );
  }
}
