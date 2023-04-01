// import 'package:flutter/material.dart';

// import '../../app_config/app_image.dart';
// import '../../widget/shared_widgets/no_data.dart';
// import '../../widget/shared_widgets/text_widget.dart';

// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:your_engineer/debugger/my_debuger.dart';

// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class ChatRoomScreen extends StatefulWidget {
//   const ChatRoomScreen({Key? key, required this.receiverName})
//       : super(key: key);
//   final String receiverName;

//   @override
//   State<ChatRoomScreen> createState() => _ChatRoomScreenState();
// }

// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   late IO.Socket socket;
//   // List<String> listChat = [];
//   List<dynamic> listChat = [];
//   bool onConnectError = false;

//   @override
//   initState() {
//     connectSocket();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     socket.disconnect();
//     socket.dispose();
//     super.dispose();
//   }

//   connectSocket() async {
//     try {
//       socket = IO.io(
//         'http://194.195.87.30:89',
//         OptionBuilder()
//             .setTransports(['websocket'])
//             .disableAutoConnect()
//             .build(),
//       );
//       myLog('start methode', socket.connected);
//       socket.connect();
//       socket.onConnect((data) {
//         myLog('onConnect', socket.connected);
//       });
//       socket.emit('addUser', 'yasir@g1.com');
//       socket.on(
//           'getMessage',
//           (data) => {
//                 setState(() {
//                   listChat.add(data);
//                 }),
//               });
//       socket.onDisconnect((data) => {
//             myLog("onDisconnect", data),
//           });
//       socket.onConnectError((data) => setState(
//             () => {
//               onConnectError = true,
//               myLog("onConnectError", data),
//             },
//           ));
//       socket.on('fromServer', (_) => myLog("fromServer", '_'));
//     } catch (e) {
//       myLog('catch error', e.toString());
//     }
//   }

//   sendMessage() {
//     myLog('sendMessage', '');
//     String message = 'Test Test';
//     if (message.isEmpty) return;

//     Map<String, dynamic> map = {
//       'receiverId': 'rasheed@g1.com',
//       'senderId': 'yasir@g1.com',
//       'text': message,
//       'time': DateTime.now().toIso8601String(),
//     };

//     socket.emit('sendMessage', {
//       map,
//       setState((() {
//         listChat.add(message);
//       }))
//     });
//   }

//   // List<MessageModel> listChat = [
//   //   MessageModel(
//   //       name: "rasheed@g1.com",
//   //       message: "Hi",
//   //       isSender: false,
//   //       imgeUrl: AppImage.img11,
//   //       messageTime: "01:22 PM"),
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _getAppBar(context, 'Rasheed'),
//       bottomNavigationBar: TextButton(
//           onPressed: () {
//             sendMessage();
//           },
//           child: Text("Send")),
//       body: SingleChildScrollView(
//         child: Builder(builder: (context) {
//           if (onConnectError) {
//             return NoData(
//               textMessage: "Connect Error",
//               imageUrlAssets: AppImage.noData,
//               onTap: (() {}),
//             );
//           }
//           return Column(
//             children: [
//               ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: listChat.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       // color: getColor(listChat[index]['senderId'].toString()),
//                       child: Column(
//                         children: [
//                           // Center(
//                           //     child: Text(listChat[index]['text'].toString())),
//                           // Center(
//                           //     child: Text(listChat[index]['time'].toString())),
//                           // Center(
//                           //     child:
//                           //         Text(listChat[index]['senderId'].toString())),
//                         ],
//                       ),
//                     );

//                     // return ChatRoomWidget(
//                     //   messageModel: listChat[index],
//                     // );
//                   }),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }

// getColor(String messageSender) {
//   if (messageSender.contains("rasheed@g1.com")) {
//     return Colors.green;
//   } else {
//     return Colors.white;
//   }
// }

// _getAppBar(BuildContext context, String recevierName) {
//   return AppBar(
//     title: Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: TextWidget(title: recevierName, fontSize: 18, color: Colors.white),
//     ),
//     leading: IconButton(
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//       icon: const Icon(Icons.navigate_before, size: 40),
//       color: Colors.white,
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:your_engineer/controller/chat_controller.dart';
import 'package:your_engineer/debugger/my_debuger.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:your_engineer/widget/shared_widgets/loading_widget.dart';

import '../../app_config/app_config.dart';
import '../../enum/all_enum.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import 'package:your_engineer/model/chat_models/chat_between_users_model.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  ChatController controller = Get.put(ChatController());
  TextEditingController messageController = TextEditingController();

  late IO.Socket socket;
  bool onConnectError = false;
  // String message = '';
  // List<ChatBetweenUsers> list = [];

  @override
  initState() {
    connectSocket();
    controller.getChatBetweenUsers();
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
      socket.emit('addUser', '"0a2e1e95-8607-48d2-9301-639945344a5e');
      socket.on(
          'getMessage',
          (data) => {
                setState(() {
                  controller.listChatBetweenUsers.add(data);
                }),
              });
      socket.onDisconnect((data) => {
            myLog("message", data),
            setState(
              () => {
                //list = data['text']
              },
            )
          });
      socket.onConnectError((data) => setState(
            () => {
              onConnectError = true,
              myLog("onConnectError", data),
            },
          ));
      socket.on('fromServer', (_) => myLog("fromServer", '_'));
      socket.on(
          'getMessage',
          (data) => {
                setState(
                  () => controller.listChatBetweenUsers
                      .add(ChatBetweenUsers.fromJson(data)),
                ),
              });
    } catch (e) {
      myLog('start methode', e.toString());
    }
  }

/**/
  sendMessage() {
    myLog('sendMessage', '');
    // String message = 'Hi abohurira';
    if (messageController.text.isEmpty) return;

    // var map = ChatBetweenUsers.fromJson({
    //   'receiverId': 'abohurira@g1.com',
    //   'senderId': '"0a2e1e95-8607-48d2-9301-639945344a5e',
    //   'text': message,
    //   'time': DateTime.now().toIso8601String(),
    // });

    Map<String, dynamic> map = {
      'receiverId': '3e801c4b-072e-433b-8065-4e791675ef37',
      'senderId': '"0a2e1e95-8607-48d2-9301-639945344a5e',
      'text': messageController.text,
      'time': DateTime.now().toIso8601String(),
    };

    socket.emit('sendMessage', {
      map,
      setState((() {
        controller.createChat(message: messageController.text);
        controller.listChatBetweenUsers.add(ChatBetweenUsers.fromJson2(map));
      }))
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios)),
      ),
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
                    controller.getChatBetweenUsers();
                  }),
            );
          } else {
            return Column(
              children: [
                const SizedBox(height: 20),
                ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  shrinkWrap: true,
                  itemCount: controller.listChatBetweenUsers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    myLog("receiverId",
                        controller.listChatBetweenUsers[index].receiverId);
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
                                    "3e801c4b-072e-433b-8065-4e791675ef37"
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
                                          "3e801c4b-072e-433b-8065-4e791675ef37"
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
                                      "3e801c4b-072e-433b-8065-4e791675ef37"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              // child: Text(
                              //   dateFormat(controller
                              //       .listChatBetweenUsers[index].createdAt
                              //       .toString()),
                              // ),
                            ),
                            // Center(child: Text(list[index]['time'].toString())),
                            // Center(child: Text(list[index]['senderId'].toString())),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                controller.loadingStateChat.value == LoadingState.loading
                    ? Center(child: CircularProgressIndicator())
                    : buildTextMessage(
                        onPressed: () {
                          sendMessage();
                        },
                        message: messageController)
                // controller.loadingStateChat.value == LoadingState.loading
                //     ? Center(child: CircularProgressIndicator())
                //     : ElevatedButton(
                //         onPressed: () {
                //           sendMessage();
                //         },
                //         child: Text("Send")),
              ],
            );
          }
          // else {
          //   if (onConnectError) {
          //     return NoData(
          //       textMessage: "Connect Error",
          //       imageUrlAssets: AppImage.noData,
          //       onTap: (() {}),
          //     );
          //   }
        }
            // },
            ),
      ),
    );
  }

  buildTextMessage({
    required TextEditingController message,
    required Function() onPressed,
  }) {
    return Stack(
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
    );
  }
}
