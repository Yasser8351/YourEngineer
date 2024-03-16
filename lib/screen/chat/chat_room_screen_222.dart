// ChatRoomScreen22222
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/controller/chat_controller.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/model/chat_models/last_chats_model.dart';
import 'package:your_engineer/screen/chat/widget/chat_list_message.dart';
import 'package:your_engineer/widget/shared_widgets/loading_widget.dart';
import 'package:your_engineer/widget/shared_widgets/reytry_error_widget.dart';

class ChatRoomScreen22222 extends StatefulWidget {
  const ChatRoomScreen22222({
    super.key,
    required this.chatsModel,
    required this.userEmail,
  });
  final Chats chatsModel;
  final String userEmail;

  @override
  State<ChatRoomScreen22222> createState() => _ChatRoomScreen22222State();
}

class _ChatRoomScreen22222State extends State<ChatRoomScreen22222> {
  ChatController chatController = Get.put(ChatController());
  TextEditingController messageController = TextEditingController();

  @override
  initState() {
    getChatBetweenUsers();
    super.initState();
  }

  ////////////// getChatBetweenUsers //////////////
  Future<void> getChatBetweenUsers() => chatController.getChatBetweenUsers(
      receiver_id: widget.chatsModel.senderId);

  ///////////// createChat //////////////
  Future<void> createChat() {
    chatController.isLoadin();
    return chatController
        .createChat(
            message: messageController.text,
            receiver_id: widget.chatsModel.receiverId)
        .then((value) => {
              chatController.isLoadin(),
              messageController.clear(),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      ApiUrl.imageUrl + widget.chatsModel.senderImg),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.chatsModel.senderName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder<ChatController>(
        builder: (controller) {
          if (controller.loadingState.value == LoadingState.initial ||
              controller.loadingState.value == LoadingState.loading) {
            return Center(child: LoadingWidget());
          } else if (controller.loadingState.value == LoadingState.error ||
              controller.loadingState.value == LoadingState.noDataFound) {
            return Center(
              child: ReyTryErrorWidget(
                  title: AppConfig.errorOoccurred.tr,
                  onTap: () {
                    controller.getChatBetweenUsers(
                        receiver_id: widget.chatsModel.senderId);
                  }),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () => getChatBetweenUsers(),
              child: ChatListMessage(
                  messageController: messageController,
                  onTapSendMessage: () => createChat(),
                  listChatBetweenUsers: controller.listChatBetweenUsers,
                  receiverId: widget.chatsModel.receiverId),
            );
          }
        },
      ),
    );
  }
}
