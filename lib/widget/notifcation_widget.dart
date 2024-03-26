import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../model/notification_model/all_notification_model.dart';

class NoticationWidget extends StatelessWidget {
  const NoticationWidget({
    Key? key,
    required this.colorScheme,
    required this.size,
    required this.notifcationModel,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final Size size;
  final Result notifcationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: notifcationModel.read == 1 ? null : Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: colorScheme.surface,
              radius: 26.0,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  size: 30,
                ),
                color: colorScheme.secondary,
              ),
            ),
            SizedBox(width: size.width * .04),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                    width: size.width / 1.5,
                    child: Text(notifcationModel.description)),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width / 1.5,
                  child: Text(
                    GetTimeAgo.parse(DateTime.parse(notifcationModel.createdAt),
                        pattern: "dd-MM-yyyy hh:mm aa", locale: 'ar'),
                    textAlign: TextAlign.start,
                  ),
                ),
                // child: Text(dateFormat(notifcationModel.createdAt))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
