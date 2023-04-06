import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../screen/chat/chat_room_screen.dart';
import 'loading_widget.dart';

class AcceptOfferOrChatWidget extends StatelessWidget {
  const AcceptOfferOrChatWidget(
      {Key? key, required this.isLoading, required this.acceptOffer})
      : super(key: key);
  final bool isLoading;
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
              Get.to(ChatRoomScreen(receiverId: '', receiverEmail: ''));
            },
            child: Text(
              "محادثة",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
