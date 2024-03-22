// ChatRoomScreen22222
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/controller/chat_controller.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/model/chat_models/chat_between_users_model.dart';
import 'package:your_engineer/model/chat_models/last_chats_model.dart';
import 'package:your_engineer/screen/chat/widget/chat_list_message.dart';
import 'package:your_engineer/widget/shared_widgets/loading_widget.dart';
import 'package:your_engineer/widget/shared_widgets/reytry_error_widget.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:your_engineer/debugger/my_debuger.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoomScreen22222 extends StatefulWidget {
  const ChatRoomScreen22222({
    super.key,
    required this.chatsModel,
    required this.userEmail,
    required this.userId,
  });
  final Chats chatsModel;
  final String userEmail;
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
    upgradedWebsocket();
    connectSocket();
    getChatBetweenUsers();
    super.initState();
  }

  upgradedWebsocket() async {
    Random r = new Random();
    String key = base64.encode(List<int>.generate(8, (_) => r.nextInt(256)));

    HttpClient client = HttpClient(/* optional security context here */);
    HttpClientRequest request = await client.get('echo.websocket.org', 80,
        '/foo/ws?api_key=myapikey'); // form the correct url here
    request.headers.add('Connection', 'upgrade');
    request.headers.add('Upgrade', 'websocket');
    request.headers
        .add('sec-websocket-version', '13'); // insert the correct version here
    request.headers.add('sec-websocket-key', key);
    HttpClientResponse response = await request.close();
    // todo check the status code, key etc
    var socket = await response.detachSocket();

    WebSocket ws = WebSocket.fromUpgradedSocket(
      socket,
      serverSide: false,
    );
  }

  /////////////////////////
  connectSocket() async {
    try {
      socket = IO.io(
          'http://62.171.175.75:84',
          // 'http://194.195.87.30:89',
          OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .setExtraHeaders(
                  {'Connection': 'upgrade', 'Upgrade': 'websocket'})
              .build());
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

  ////////////// getChatBetweenUsers //////////////
  Future<void> getChatBetweenUsers() => chatController.getChatBetweenUsers(
      receiver_id: widget.chatsModel.senderId.contains(widget.userId)
          ? widget.chatsModel.receiverId
          : widget.chatsModel.senderId);

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

  ////////////////////
  handleMessage(dynamic data) {
    myLog("getMessage", "");
    var d = data as Map<String, dynamic>;
    myLog(data.toString(), "");
    chatController.listChatBetweenUsers.add(ChatBetweenUsers.fromJson2(d));
    setState(() {});
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
