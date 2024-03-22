import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/controller/chat_controller.dart';

class TextFormSendMessage extends GetView<ChatController> {
  const TextFormSendMessage(
      {super.key,
      required this.onTapSendMessage,
      required this.messageController});
  final Function() onTapSendMessage;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: Get.height * .08,
        // height: 60,
        width: double.infinity,
        color: Colors.grey.shade100,
        child: Row(
          children: [
            SizedBox(
              width: Get.width * .03,
            ),
            GestureDetector(
              onTap: () async {
                controller.getImageFromGallery();
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            GetBuilder<ChatController>(builder: (_) {
              return Expanded(
                child: controller.imageMessage != null
                    ? Row(
                        children: [
                          Image.file(
                            controller.imageMessage!,
                            // width: 200,
                            height: Get.height * 1,
                          ),
                          IconButton(
                              onPressed: () => controller.clearImageMessage(),
                              icon: Icon(Icons.close)),
                        ],
                      )
                    : TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
              );
            }),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: onTapSendMessage,
              child: GetBuilder<ChatController>(builder: (chatController) {
                return chatController.isLoadingMessage
                    ? CircularProgressIndicator(color: Colors.white)
                    : Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      );
              }),
              backgroundColor: Colors.green,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}
