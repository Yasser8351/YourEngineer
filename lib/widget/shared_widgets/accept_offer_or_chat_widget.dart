import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../screen/chat/chat_room_screen.dart';
import 'loading_widget.dart';

class AcceptOfferOrChatWidget extends StatelessWidget {
  const AcceptOfferOrChatWidget(
      {Key? key,
      required this.isLoading,
      required this.acceptOffer,
      required this.receiverId,
      required this.senderId,
      required this.receiverEmail,
      required this.receiverName,
      required this.image})
      : super(key: key);
  final bool isLoading;
  final String receiverId;
  final String senderId;
  final String receiverEmail;
  final String receiverName;
  final String image;
  final Function(BuildContext context) acceptOffer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        isLoading
            ? LoadingWidget()
            : ElevatedButton(
                onPressed: () async => acceptOffer(context),
                child: Text(
                  "قبول العرض",
                  style: TextStyle(color: Colors.white),
                )),
        SizedBox(width: 30),
        ElevatedButton(
            onPressed: () {
              Get.to(ChatRoomScreen(
                receiverId: receiverId,
                receiverEmail: receiverEmail,
                image: image,
                receiverName: receiverName,
                senderId: senderId,
              ));
            },
            child: Text(
              "محادثة",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
