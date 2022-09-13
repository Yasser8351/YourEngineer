import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../app_config/app_config.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
    required this.imageUrlAssets,
    required this.textMessage,
    required this.onTap,
    this.isPostScreen = false,
  }) : super(key: key);

  final String imageUrlAssets;
  final String textMessage;
  final bool isPostScreen;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrlAssets,
              height: size.height * .3,
              width: size.height * .4,
            ),
            SizedBox(height: size.height * .03),
            TextWidget(
              title: textMessage,
              fontSize: 16,
              color: colorScheme.onSecondary,
            ),
            SizedBox(height: size.height * .003),
            isPostScreen
                ? InkWell(
                    onTap: onTap,
                    child: TextWidget(
                      title: AppConfig.addSomeProject,
                      fontSize: 20,
                      color: colorScheme.primary,
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
