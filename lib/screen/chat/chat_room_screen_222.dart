// ChatRoomScreen22222

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/controller/chat_controller.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/model/chat_models/chat_between_users_model.dart';
import 'package:your_engineer/model/chat_models/last_chats_model.dart';
import 'package:your_engineer/screen/chat/widget/chat_list_message.dart';
import 'package:your_engineer/widget/shared_widgets/full_image.dart';
import 'package:your_engineer/widget/shared_widgets/loading_widget.dart';
import 'package:your_engineer/widget/shared_widgets/reytry_error_widget.dart';
import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoomScreen22222 extends StatefulWidget {
  const ChatRoomScreen22222({
    super.key,
    required this.chatsModel,
    required this.userEmail,
    required this.userId,
    this.showAllLink = false,
  });
  final Chats chatsModel;
  final String userEmail;
  final bool showAllLink;
  final String userId;

  @override
  State<ChatRoomScreen22222> createState() => _ChatRoomScreen22222State();
}

class _ChatRoomScreen22222State extends State<ChatRoomScreen22222> {
  ChatController chatController = Get.put(ChatController());
  TextEditingController messageController = TextEditingController();
  late IO.Socket socket;
  bool onConnectError = false;

  @override
  initState() {
    myLog("userEmail", widget.userEmail);
    myLog("userId", widget.userId);
    myLog("recieverName", widget.chatsModel.recieverName);
    connectSocket();

    getChatBetweenUsers();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    socket.disconnect();
    socket.dispose();
    chatController.scrollController.dispose();
    // _streamController.close();

    myLog("socket.dispose", '');
  }

  /////////////////////////
  connectSocket() async {
    try {
      socket = IO.io(
          'http://62.171.175.75:84',
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .setExtraHeaders(
                  {'Connection': 'upgrade', 'Upgrade': 'websocket'})
              .build());
      socket.connect();
      socket.onConnect((data) {
        myLog('onConnect', socket.connected);
      });
      socket.emit('addUser', chatController.email);
      socket.on('getMessage', handleMessage);
      socket.onDisconnect((data) => {
            myLog("message", data),
            setState(
              () => {},
            )
          });
      socket.onConnectError((data) => setState(
            () => {
              onConnectError = true,
              myLog("onConnectError", data),
            },
          ));
      socket.on('fromServer', (_) => myLog("fromServer", '_'));

      // io.listen(3000);
    } catch (e) {
      myLog('catch error', e.toString());
    }
  }

  ////////////////// sendMessage ///////////
  sendMessage(
    String fileUrl,
    String messageType,
  ) {
    try {
      if (messageController.text.isEmpty) return;

      Map map = {
        'senderId': widget.userEmail,
        'receiverId': widget.chatsModel.recieverEmail.contains(widget.userEmail)
            ? widget.chatsModel.senderEmail
            : widget.chatsModel.recieverEmail,
        'text': messageController.text,
        'fileUrl': fileUrl,
        'message_type': messageType,
        'time': DateTime.now().toIso8601String(),
      };
      socket.emit('sendMessage', map);
      myLog('sendMessage ', "$map");
    } catch (error) {
      myLog('error', "$error");
    }
  }

  ////////////// getChatBetweenUsers //////////////
  Future<void> getChatBetweenUsers() => chatController
          .getChatBetweenUsers(
              receiver_id: widget.chatsModel.senderId.contains(widget.userId)
                  ? widget.chatsModel.receiverId
                  : widget.chatsModel.senderId)
          .then((value) {
        // chatController.scrollToBottom();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (chatController.scrollController.hasClients) {
            chatController.scrollToBottom();
          }
        });
      });

  ///////////// createChat //////////////
  Future<void> createChat() {
    chatController.isLoadin();
    return chatController
        .addCreateChat(
            message: messageController.text,
            receiver_id: widget.chatsModel.senderId.contains(widget.userId)
                ? widget.chatsModel.receiverId
                : widget.chatsModel.senderId)
        .then((value) => {
              if (value != null)
                {
                  myLog('addCreateChat',
                      "receiverId : ${value.receiverId} \n senderId ${value.senderId}"),
                  sendMessage(value.fileUrl!, value.messageType!),
                  chatController.scrollToBottom(),
                  chatController.isLoadin(),
                  messageController.clear(),
                }
            });
  }

  ////////////////////
  handleMessage(dynamic data) {
    var d = data as Map<String, dynamic>;
    var json = ChatBetweenUsers.fromJson2(d);
    chatController.listChatBetweenUsers.add(json);
    chatController.scrollToBottom();
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
                  InkWell(
                    onTap: () => Get.to(() => FullImage(
                        imageUrl: widget.showAllLink
                            ? widget.chatsModel.senderImg
                            : ApiUrl.imageUrl + widget.chatsModel.senderImg)),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.showAllLink
                          ? widget.chatsModel.senderImg
                          : ApiUrl.imageUrl + widget.chatsModel.senderImg),
                      maxRadius: 20,
                    ),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BodyListCathRoom(
            scrollController: chatController.scrollController,
            getChatBetweenUsers: getChatBetweenUsers,
            sendMessage: createChat,
            // sendMessage: sendMessage,
            messageController: messageController,
            receiverId: widget.chatsModel.receiverId));
  }
}

class BodyListCathRoom extends GetView<ChatController> {
  const BodyListCathRoom(
      {super.key,
      required this.getChatBetweenUsers,
      required this.sendMessage,
      required this.scrollController,
      required this.messageController,
      required this.receiverId});
  final Function() getChatBetweenUsers;
  final Function() sendMessage;
  final TextEditingController messageController;
  final String receiverId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
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
                  getChatBetweenUsers();
                }),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () => getChatBetweenUsers(),
            child: ChatListMessage(
                controller: scrollController,
                messageController: messageController,
                // onTapSendMessage: () {
                //   createChat();
                // },
                onTapSendMessage: () => sendMessage(),
                listChatBetweenUsers: controller.listChatBetweenUsers,
                receiverId: receiverId),
          );
        }
      },
    );
  }
}
/*
 StreamBuilder<String>(
              stream: messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Padding( 
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListTile(
                    title: Text("Received Message: ${snapshot.data ?? ""}"),
                  ),
                );
*/
