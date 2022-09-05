import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/text_widget.dart';

class TextWithIconWidget extends StatelessWidget {
  const TextWithIconWidget({Key? key}) : super(key: key);

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
        Icon(
          Icons.notifications_none,
          color: Theme.of(context).colorScheme.onSecondary,
          size: 30,
        )
      ],
    );
  }
}
