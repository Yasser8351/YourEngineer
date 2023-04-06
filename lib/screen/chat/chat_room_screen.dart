import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:your_engineer/controller/chat_controller.dart';
import 'package:your_engineer/debugger/my_debuger.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:your_engineer/screen/tab_screen.dart';
import 'package:your_engineer/widget/shared_widgets/loading_widget.dart';

import '../../app_config/app_config.dart';
import '../../enum/all_enum.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import 'package:your_engineer/model/chat_models/chat_between_users_model.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen(
      {Key? key, required this.receiverId, required this.receiverEmail})
      : super(key: key);
  final String receiverId;
  final String receiverEmail;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  ChatController chatController = Get.put(ChatController());
  TextEditingController messageController = TextEditingController();

  // ScrollController scrollController = ScrollController(); "dash2022tech@gmail.com

  late IO.Socket socket;
  bool onConnectError = false;
  @override
  initState() {
    connectSocket();
    chatController.getChatBetweenUsers(receiver_id: widget.receiverId);
    chatController.getUserId();
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
    // scrollController.jumpTo(1);
    chatController.listChatBetweenUsers.add(ChatBetweenUsers.fromJson2(d));
    setState(() {});
  }

  sendMessage() {
    myLog('sendMessage', '');
    if (messageController.text.isEmpty) return;

    Map<String, dynamic> map = {
      'senderId': chatController.email,
      'receiverId': widget.receiverEmail,
      // 'receiverId': "rasheed@g1.com",
      'text': messageController.text,
      'time': DateTime.now().toIso8601String(),
      'fileUrl': '',
      'message_type': 'text',
    };

    socket.emit('sendMessage', {
      map,
      setState((() {
        chatController.createChat(
            message: messageController.text, receiver_id: widget.receiverId);
        chatController.listChatBetweenUsers
            .add(ChatBetweenUsers.fromJson2(map));
        messageController.clear();
      }))
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    // scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TabScreen(selectIndex: 1),
                )),
            icon: Icon(Icons.arrow_back_ios)),
      ),
      bottomNavigationBar: buildTextMessage(
          onPressed: () {
            // scrollList();
            sendMessage();
          },
          message: messageController),
      body: SingleChildScrollView(
        child: GetBuilder<ChatController>(builder: (controller) {
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
                        receiver_id: widget.receiverId);
                  }),
            );
          } else {
            return Column(
              children: [
                const SizedBox(height: 20),
                // ListView.separated(
                ListView.separated(
                  reverse: true,
                  // controller: scrollController,
                  separatorBuilder: (context, index) => const Divider(),
                  shrinkWrap: true,
                  itemCount: controller.listChatBetweenUsers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => SupportChatScreen(
                        //           imageUrl: listChat[index].imgeUrl,
                        //           name: listChat[index].name,
                        //         )));
                        // Navigator.of(context).pushNamed(AppConfig.chatRoom);
                      },
                      // child: ChatWidget(
                      //   messageModel: listChat[index],
                      child: Container(
                        width: MediaQuery.of(context).size.width * .1,
                        color:
                            controller.listChatBetweenUsers[index].receiverId ==
                                    controller.userId
                                ? Colors.grey
                                : Colors.green,
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Align(
                                  alignment: controller
                                              .listChatBetweenUsers[index]
                                              .receiverId ==
                                          controller.userId
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
                            Align(
                              alignment: controller.listChatBetweenUsers[index]
                                          .receiverId ==
                                      controller.userId
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Text(dateFormat(controller
                                  .listChatBetweenUsers[index].createdAt
                                  .toString())),
                            ),
                          ],
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
    return Container(
      height: 60,
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
                        color: Colors.lightBlue,
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
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
