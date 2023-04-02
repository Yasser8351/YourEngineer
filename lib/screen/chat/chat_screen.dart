import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/controller/chat_controller.dart';
import 'package:your_engineer/screen/chat/chat_room_screen.dart';
import 'package:your_engineer/widget/chat_widget.dart';

import '../../app_config/app_config.dart';
import '../../enum/all_enum.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import '../../widget/shared_widgets/shimmer_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    // chatController.getLastchats();
  }

  // List<MessageModel> listChat = [
  //   MessageModel(
  //       name: "rasheed@g1.com",
  //       message: "Hi",
  //       imgeUrl: AppImage.img11,
  //       messageTime: "01:22 PM"),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ChatController>(builder: (controller) {
          if (controller.loadingState.value == LoadingState.initial ||
              controller.loadingState.value == LoadingState.loading) {
            return ShimmerWidget(size: MediaQuery.of(context).size);
          } else if (controller.loadingState.value == LoadingState.error ||
              controller.loadingState.value == LoadingState.noDataFound) {
            return Center(
              child: ReyTryErrorWidget(
                  title: AppConfig.errorOoccurred.tr,
                  onTap: () {
                    controller.getLastchats();
                  }),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () => controller.getLastchats(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    shrinkWrap: true,
                    itemCount: controller.lastChatsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatRoomScreen(
                              receiverId: controller.userId ==
                                      controller.lastChatsList[index].senderId
                                  ? controller.lastChatsList[index].receiverId
                                  : controller.lastChatsList[index].senderId,
                            ),
                          ));
                        },
                        child: ChatWidget(
                          messageModel: controller.lastChatsList[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
            // SingleChildScrollView(
            //   child: Center(
            //     child: NoData(
            //       textMessage: AppConfig.noMessageYet.tr,
            //       imageUrlAssets: AppImage.noData.tr,
            //       onTap: (() {}),
            //     ),
            //   ),
            // );

          }
        }));
  }
}
