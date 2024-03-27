import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/model/chat_models/last_chats_model.dart';
import 'package:your_engineer/screen/chat/chat_room_screen_222.dart';
import 'package:your_engineer/sharedpref/user_share_pref.dart';

import 'loading_widget.dart';

class AcceptOfferOrChatWidget extends StatefulWidget {
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
  State<AcceptOfferOrChatWidget> createState() =>
      _AcceptOfferOrChatWidgetState();
}

class _AcceptOfferOrChatWidgetState extends State<AcceptOfferOrChatWidget> {
  String email = "";
  String userId = "";

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  getEmail() async {
    SharedPrefUser prefs = SharedPrefUser();
    String _email = await prefs.getEmail();
    String _id = await prefs.getId();

    setState(() {
      email = _email;
      userId = _id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        widget.isLoading
            ? LoadingWidget()
            : ElevatedButton(
                onPressed: () async => widget.acceptOffer(context),
                child: Text(
                  AppConfig.acceptOffer.tr,
                  style: TextStyle(color: Colors.white),
                )),
        SizedBox(width: 30),
        ElevatedButton(
            onPressed: () {
              Get.to(ChatRoomScreen22222(
                userId: userId,
                showAllLink: true,
                userEmail: email,
                chatsModel: Chats(
                  createdAt: "",
                  id: "",
                  message: "",
                  messageType: "",
                  recieverImg: widget.image,
                  recieverName: widget.receiverName,
                  senderImg: widget.image,
                  seqnum: 0,
                  senderName: widget.receiverName,
                  updatedAt: "",
                  receiverId: widget.receiverId,
                  recieverEmail: widget.receiverEmail,
                  // image: image,
                  // receiverName: receiverName,
                  senderId: widget.senderId,
                  senderEmail: "",
                  // image: resulte['client']['imgPath'],
                  // receiverName: resulte['client']['fullname'],
                ),
                // receiverId: receiverId,
                // receiverEmail: receiverEmail,
                // image: image,
                // receiverName: receiverName,
                // senderId: senderId,
              ));
            },
            child: Text(
              AppConfig.chatEng.tr,
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
