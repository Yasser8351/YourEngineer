import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/text_widget.dart';

class TextWithIconWidget extends StatelessWidget {
  const TextWithIconWidget({Key? key, required this.onTapNotifications})
      : super(key: key);
  final Function() onTapNotifications;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          title: AppConfig.appName,
          fontSize: 20,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        IconButton(
          onPressed: onTapNotifications,
          iconSize: 30,
          icon: const Icon(Icons.notifications_none),
          color: Theme.of(context).colorScheme.onSecondary,
        )
      ],
    );
  }
}
