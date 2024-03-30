import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/utilits/app_ui_helpers.dart';
import 'package:your_engineer/widget/shared_widgets/full_image.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../model/chat_models/last_chats_model.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.messageModel, this.userEmail = ''})
      : super(key: key);

  final Chats messageModel;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    var senderImg = ApiUrl.imageUrl + messageModel.senderImg;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Row(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextWidget(
                      title: messageModel.senderEmail.contains(userEmail)
                          ? messageModel.recieverName
                          : messageModel.senderName,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      isTextEnd: true,
                      color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // messageModel.senderEmail.contains(userEmail)
                      //     ? Icon(Icons.done_all,
                      //         color: Colors.green, size: Get.width * .05)
                      //     : const SizedBox(),
                      SizedBox(width: 30),
                      Container(
                        height: Get.width * .1,
                        // color: Colors.red,
                        width: Get.width * .6,
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextWidget(
                              title: messageModel.messageType.contains("file")
                                  ? "صورة"
                                  : messageModel.message,
                              textOverflow: TextOverflow.clip,
                              isTextEnd: true,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    GetTimeAgo.parse(DateTime.parse(messageModel.createdAt),
                        pattern: "dd-MM-yyyy hh:mm aa", locale: 'ar'),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              horizontalSpaceRegular,
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FullImage(imageUrl: senderImg)));
                },
                child: CircleAvatar(
                  radius: Get.width * .09,
                  // child: Image.network(senderImg),
                  backgroundImage: NetworkImage(
                    senderImg,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
