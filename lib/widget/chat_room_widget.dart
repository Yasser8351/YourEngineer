import 'package:flutter/material.dart';
import 'package:your_engineer/widget/card_decoration.dart';

import '../model/message_model.dart';

class ChatRoomWidget extends StatelessWidget {
  const ChatRoomWidget({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: CardDecoration(
          height: 50,
          width: 800,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(messageModel.message),
            ),
          ),
          onTap: () {}),
      // trailing: Text(messageModel.messageTime),
      // leading: CircleAvatar(
      //   radius: 30.0,
      //   backgroundImage: AssetImage(
      //     messageModel.imgeUrl,
      //   ),
      // ),
    );
  }
}
