import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

class ChatRoomWidget extends StatelessWidget {
  const ChatRoomWidget({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  final String messageModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final messagelength = messageModel.message.length;
    return ListTile(
      subtitle: Card(
        // height: size.height / messagelength / 5,
        // height: 90,
        // width: size.width * .9,
        // color: messageModel.isSender ? Colors.green : Colors.green,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: messageModel['time']
              //     ? MainAxisAlignment.end
              //     : MainAxisAlignment.start,
              children: [
                SizedBox(height: size.height * .02),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget(
                      isTextStart: true,
                      title: messageModel,
                      color: Colors.black,
                      fontSize: 18),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(messageModel)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatRoomWidget2 extends StatelessWidget {
  const ChatRoomWidget2({
    Key? key,
    required this.messageModel,
  }) : super(key: key);

  final dynamic messageModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final messagelength = messageModel.message.length;
    return ListTile(
      subtitle: Card(
        // height: size.height / messagelength / 5,
        // height: 90,
        // width: size.width * .9,
        // color: messageModel.isSender ? Colors.green : Colors.green,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: messageModel['time']
              //     ? MainAxisAlignment.end
              //     : MainAxisAlignment.start,
              children: [
                SizedBox(height: size.height * .02),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget(
                      isTextStart: true,
                      title: messageModel.message,
                      color: Colors.black,
                      fontSize: 18),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(messageModel)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
