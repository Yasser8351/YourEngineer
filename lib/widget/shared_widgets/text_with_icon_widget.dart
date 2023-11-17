import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

class TextWithIconWidget extends StatelessWidget {
  const TextWithIconWidget(
      {Key? key,
      required this.onTapNotifications,
      required this.notificationsCount})
      : super(key: key);
  final Function() onTapNotifications;
  final int notificationsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          title: AppConfig.appName.tr,
          fontSize: 20,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        notificationsCount > 0
            ? Badge(
                label: Text(
                  notificationsCount.toString(),
                  style: TextStyle(
                      color: Colors.white, fontSize: Get.width * .045),
                ),
                backgroundColor: Colors.green,
                child: IconButton(
                  onPressed: onTapNotifications,
                  iconSize: 30,
                  icon: const Icon(Icons.notifications_none),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              )
            : IconButton(
                onPressed: onTapNotifications,
                iconSize: 30,
                icon: const Icon(Icons.notifications_none),
                color: Theme.of(context).colorScheme.onSecondary,
              ),
      ],
    );
  }
}
