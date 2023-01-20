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
import 'package:socket_io_client/socket_io_client.dart';
import 'package:your_engineer/debugger/my_debuger.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../app_config/app_image.dart';
import '../../widget/shared_widgets/no_data.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late IO.Socket socket;
  bool onConnectError = false;
  String message = '';

  @override
  initState() {
    connectSocket();
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
      socket.emit('addUser', 'yasir@g1.com');
      socket.on(
          'getMessage',
          (data) => {
                setState(() {
                  list.add(data);
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
                  () => list.add(data),
                ),
              });
    } catch (e) {
      myLog('start methode', e.toString());
    }
  }

/**/
  sendMessage() {
    myLog('sendMessage', '');
    String message = 'Test Test';
    if (message.isEmpty) return;

    Map<String, dynamic> map = {
      'receiverId': 'rasheed@g1.com',
      'senderId': 'yasir@g1.com',
      'text': message,
      'time': DateTime.now().toIso8601String(),
    };

    socket.emit('sendMessage', {
      map,
      setState((() {
        list.add(map);
      }))
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  List<dynamic> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            sendMessage();
          },
          child: Text("data")),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          if (onConnectError) {
            return NoData(
              textMessage: "Connect Error",
              imageUrlAssets: AppImage.noData,
              onTap: (() {}),
            );
          }
          return Column(
            children: [
              const SizedBox(height: 20),
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                itemCount: list.length,
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
                    // ),

                    child: Column(
                      children: [
                        Center(child: Text(list[index]['text'].toString())),
                        Center(child: Text(list[index]['time'].toString())),
                        Center(child: Text(list[index]['senderId'].toString())),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
