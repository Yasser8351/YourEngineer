import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:your_engineer/app_config/app_config.dart';

import '../../utilits/helper.dart';
import '../../widget/shared_widgets/fcb_input.dart';
import '../../widget/shared_widgets/my_button.dart';
import '../../widget/shared_widgets/text_widget.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen(
      {Key? key,
      this.SupportChatScreenId = "",
      this.imageUrl = AppConfig.support,
      this.name = "Support",
      this.image = "",
      this.email = "",
      this.specialization = "",
      this.workFrom = "",
      this.workTo = "",
      this.aboutDoctor = ""})
      : super(key: key);
  final String SupportChatScreenId;
  final String imageUrl;
  final String name;
  final String image;
  final String email;
  final String specialization;
  final String workFrom;
  final String workTo;
  final String aboutDoctor;

  @override
  _SupportChatScreenState createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final TextEditingController _message = TextEditingController();

  final _scrollController = ScrollController();

  void onSendMessage() async {
    if (_message.text.trim().isNotEmpty) {
      setState(() {
        _message.clear();
      });
    } else {
      print("Enter Some Text");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void __scrollListToBottom() {
    Timer(
        const Duration(milliseconds: 500),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn));
  }

  bool isLoading = false;
  TextEditingController _descriptionController = TextEditingController();

  sendEmail({required String body, required String title}) async {
    String data = 'رسالة جديدة';

    setState(() {
      // _isLoading = true;
    });

    // String username = "username@c-pinal.com";
    // String password = "password";
    String username = "sender@gulfsmo.net";
    String password = "-zxu[vtQ.pU(";
    final smtpServer = new SmtpServer("mail.gulfsmo.net",
        // final smtpServer = new SmtpServer("domin.com",
        username: username,
        password: password,
        port: 465,
        ssl: true);

    final message = Message()
      ..from = Address(username, AppConfig.appName)
      //..recipients.add('batagroup.info@gmail.com')
      ..recipients.add('yasser8351@gmail.com')
      ..subject = _message.text
      ..text = data
      ..html = data;

    try {
      await send(message, smtpServer);
      setState(() {
        // _isLoading = false;
      });
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: ((context) => CompletSend())));
    } on MailerException {
      setState(
        () {
          // _isLoading = false;
        },
      );

      // toastMessage(AppConfig.notsendemail);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _getAppBar(context, widget.name, widget.imageUrl),
      // bottomNavigationBar: Container(
      //   height: size.height / 11,
      //   width: size.width,
      //   color: Theme.of(context).colorScheme.primary,
      //   alignment: Alignment.center,
      //   child: SizedBox(
      //     height: size.height / 12,
      //     width: size.width / 1.1,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         SizedBox(
      //           height: size.height / 17,
      //           width: size.width / 1.3,
      //           child: TextField(
      //             style: const TextStyle(color: Colors.white),
      //             cursorColor: Colors.white,
      //             controller: _message,
      //             decoration: const InputDecoration(
      //               hintStyle: TextStyle(
      //                 color: Colors.white,
      //               ),
      //               labelStyle: TextStyle(
      //                 color: Colors.white,
      //               ),
      //               hintText: "Send Message...",
      //               // border: OutlineInputBorder(
      //               //   borderRadius: BorderRadius.circular(8),
      //               // ),
      //             ),
      //           ),
      //         ),
      //         IconButton(
      //             icon: const Icon(
      //               Icons.send,
      //               color: Colors.white,
      //             ),
      //             onPressed: onSendMessage),
      //       ],
      //     ),
      //   ),
      // ),

      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (ctx) => Ch
                  // ));
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFaildInput(
                      label: "email",
                      controller: _descriptionController,
                      inputType: TextInputType.text,
                      maxLines: 1,
                      hint: "add Your Email", labelPaddingBottom: 20,
                      // validationMessages: accountValidationMessages,
                      textDirection: TextDirection.ltr,
                    ),
                    SizedBox(height: 10),
                    TextFaildInput(
                      label: "message",
                      controller: _descriptionController,
                      inputType: TextInputType.text,
                      maxLines: 5,
                      hint: "add Your Message", labelPaddingBottom: 20,
                      // validationMessages: accountValidationMessages,
                      textDirection: TextDirection.ltr,
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      busy: isLoading,
                      text: "submit",
                      color: Theme.of(context).colorScheme.primary,
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (_descriptionController.text.isEmpty) {
                          Helper.showError(
                              context: context, subtitle: "pleaseEnterMessage");
                        } else {
                          // await emergencyProvider
                          //     .addContactUs(context,
                          //         description: _descriptionController.text)
                          //     .then((value) => setState(() {
                          //           _descriptionController.clear();

                          //           isLoading = false;
                          //         }));
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Divider(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  _getAppBar(BuildContext context, String name, String imageUrl) {
    return AppBar(
      title: Row(
        children: [
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => FullImage(imageUrl: imageUrl)));
          //   },
          //   child: CircleAvatar(
          //     maxRadius: 25,
          //     backgroundColor: Theme.of(context).primaryColor,
          //     backgroundImage: AssetImage(
          //       imageUrl,
          //     ),
          //   ),
          // ),
          const SizedBox(width: 30),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextWidget(title: name, fontSize: 18, color: Colors.white),
          ),
        ],
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.navigate_before, size: 40),
        color: Colors.white,
      ),
    );
  }
}

Widget messages(Size size, Map<String, dynamic> map) {
  // var day = DateTime.fromMicrosecondsSinceEpoch(map['time']);
  //DateTime date = DateTime.now();
  DateTime.parse(map['time'].toDate().toString());

  // print(DateFormat('dd-MMM-yyy').format(date));
  return Container(
    width: size.width,
    alignment: Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade200,
      ),
      child: Column(
        children: [
          Text(
            map['message'],
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    ),
  );
}
