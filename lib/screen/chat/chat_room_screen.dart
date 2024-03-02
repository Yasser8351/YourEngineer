import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:your_engineer/controller/chat_controller.dart';
import 'package:your_engineer/debugger/my_debuger.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:your_engineer/screen/tab_screen.dart';
import 'package:your_engineer/widget/shared_widgets/full_image.dart';
import 'package:your_engineer/widget/shared_widgets/loading_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../app_config/app_config.dart';
import '../../enum/all_enum.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import 'package:your_engineer/model/chat_models/chat_between_users_model.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    Key? key,
    required this.receiverId,
    required this.receiverEmail,
    required this.receiverName,
    required this.senderId,
    required this.image,
  }) : super(key: key);
  final String receiverId;
  final String senderId;
  final String receiverEmail;
  final String receiverName;
  final String image;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  ChatController chatController = Get.put(ChatController());
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;

  ScrollController scrollController = ScrollController();

  late IO.Socket socket;
  bool onConnectError = false;
  @override
  initState() {
    log("senderId senderId " + widget.senderId);
    connectSocket();
    chatController.getChatBetweenUsers(receiver_id: widget.senderId);
    chatController.getEmail();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
    super.initState();
  }

  connectSocket() async {
    try {
      socket = IO.io(
        'http://194.195.87.30:89',
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build(),
      );
      myLog('start methode', socket.connected);
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
    } catch (e) {
      myLog('catch error', e.toString());
    }
  }

  handleMessage(dynamic data) {
    log("getMessage");
    var d = data as Map<String, dynamic>;
    log(data.toString());
    chatController.listChatBetweenUsers.add(ChatBetweenUsers.fromJson2(d));
    setState(() {});
  }

  sendMessage() {
    myLog('sendMessage', chatController.email);
    myLog('sendMessage', widget.receiverEmail);
    if (messageController.text.isEmpty) return;

    Map<String, dynamic> map = {
      'senderId': chatController.email,
      'receiverId': widget.receiverEmail,
      'text': messageController.text,
      'time': DateTime.now().toIso8601String(),
      'fileUrl': '',
      'message_type': 'text',
    };

    socket.emit('sendMessage', {
      map,
      setState(
        () => isLoading = !isLoading,
      ),
      chatController
          .createChat(
              message: messageController.text, receiver_id: widget.senderId)
          .then((value) => {
                setState(() {
                  isLoading = !isLoading;
                  chatController.listChatBetweenUsers
                      .add(ChatBetweenUsers.fromJson2(map));
                  messageController.clear();
                }),
              })
    });

    // }))
    // });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    scrollController.dispose();
    super.dispose();
  }

  scrollListToBottom() {
    log("scrollListToBottom");
    Timer(
        Duration(milliseconds: 500),
        () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => FullImage(imageUrl: widget.image),
              )),
              child: CircleAvatar(
                // backgroundColor: colorScheme.surface,
                radius: 26.0,
                // child: Image.network(widget.image),
                backgroundImage: NetworkImage(widget.image),
              ),
            ),
            SizedBox(width: 15),
            TextWidget(
                title: widget.receiverName, fontSize: 16, color: Colors.white),
          ],
        ),
        leading: IconButton(
            onPressed: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TabScreen(selectIndex: 1),
                )),
            icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      bottomNavigationBar: buildTextMessage(
          onPressed: () {
            // scrollList();
            sendMessage();
          },
          message: messageController),
      body: SingleChildScrollView(
        child: GetBuilder<ChatController>(builder: (controller) {
          controller.listChatBetweenUsers =
              controller.listChatBetweenUsers.reversed.toList();
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
                        receiver_id: widget.senderId);
                  }),
            );
          } else {
            return Column(
              children: [
                const SizedBox(height: 20),
                // ListView.separated(
                ListView.separated(
                  reverse: true,
                  controller: scrollController,
                  separatorBuilder: (context, index) => const Divider(),
                  shrinkWrap: true,
                  itemCount: controller.listChatBetweenUsers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // scrollListToBottom();

                    return InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => SupportChatScreen(
                        //           imageUrl: listChat[index].imgeUrl,
                        //           name: listChat[index].name,
                        //         )));
                        // Navigator.of(context).pushNamed(AppConfig.chatRoom);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Container(
                          width: Get.width * .1,
                          decoration: BoxDecoration(
                              color: controller
                                      .listChatBetweenUsers[index].receiverId!
                                      .contains(controller.userId)
                                  ? Colors.grey.shade300
                                  : Colors.green.shade100,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade50,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Align(
                                    alignment: controller
                                            .listChatBetweenUsers[index]
                                            .receiverId!
                                            .contains(controller.userId)
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Text(
                                      controller
                                          .listChatBetweenUsers[index].message
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 10),
                                child: Align(
                                  alignment: controller
                                          .listChatBetweenUsers[index]
                                          .receiverId!
                                          .contains(controller.userId)
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Text(dateFormat(controller
                                      .listChatBetweenUsers[index].createdAt
                                      .toString())),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  // scrollList() {
  //   log("scrollList");
  //   scrollController.animateTo(
  //     0.0,
  //     curve: Curves.easeOut,
  //     duration: const Duration(milliseconds: 300),
  //   );
  // }

  buildTextMessage({
    required TextEditingController message,
    required Function() onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Get.height * .07,
        color: Colors.red,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
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
                    Expanded(
                      child: TextField(
                        controller: message,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: onPressed,
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                      backgroundColor: Colors.green,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
