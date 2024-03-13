import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/utilits/helper.dart';
import 'package:your_engineer/widget/shared_widgets/full_image.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../model/chat_models/last_chats_model.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.messageModel, this.userEmail = ''})
      : super(key: key);

  final Chats messageModel;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    print("userEmail " + userEmail.toString());
    var senderImg = ApiUrl.imageUrl + messageModel.senderImg;

    return Row(
      children: [
        SizedBox(width: 20),
        InkWell(
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
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextWidget(
                  // title: userEmail,
                  title: messageModel.senderEmail.contains(userEmail)
                      ? messageModel.recieverName
                      : messageModel.senderName,
                  fontSize: 16,
                  isTextEnd: true,
                  color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  messageModel.senderEmail.contains(userEmail)
                      ? Icon(Icons.done_all,
                          color: Colors.green, size: Get.width * .05)
                      : const SizedBox(),
                  SizedBox(width: 30),
                  Container(
                    height: Get.width * .1,
                    // width: Get.width * .31,
                    child: Center(
                      child: TextWidget(
                          title: messageModel.message,
                          textOverflow: TextOverflow.clip,
                          isTextEnd: true,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Text(dateFormat(messageModel.createdAt)),
            ],
          ),
        ),
      ],
    );

    // return ListTile(
    //   title: TextWidget(
    //       title: messageModel.recieverName, fontSize: 14, color: Colors.black),
    //   subtitle: Row(
    //     children: [
    //       messageModel.senderEmail.contains(userEmail)
    //           ? Icon(Icons.done_all, color: Colors.green, size: Get.width * .05)
    //           : const SizedBox(),
    //       Container(
    //         height: Get.width * .1,
    //         width: Get.width * .31,
    //         child: Center(
    //           child: TextWidget(
    //               title: messageModel.message,
    //               textOverflow: TextOverflow.clip,
    //               fontSize: 14,
    //               color: Colors.black),
    //         ),
    //       ),
    //     ],
    //   ),
    //   // trailing: Text(dateFormat(messageModel.createdAt)),
    //   leading: InkWell(
    //     onTap: () {
    //       Navigator.of(context).push(MaterialPageRoute(
    //           builder: (context) => FullImage(imageUrl: senderImg)));
    //     },
    //     child: CircleAvatar(
    //       radius: 30.0,
    //       // child: Image.network(senderImg),
    //       backgroundImage: NetworkImage(
    //         senderImg,
    //       ),
    //     ),
    //   ),
    // );
  }
}
