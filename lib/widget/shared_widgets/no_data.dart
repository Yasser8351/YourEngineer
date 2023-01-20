import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../app_config/app_config.dart';
import '../../app_config/app_image.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
    this.imageUrlAssets = AppImage.noData,
    this.textMessage = AppConfig.noMessageYet,
    this.onTap = null,
    this.isPostScreen = false,
    this.width = 500,
    this.height = 500,
  }) : super(key: key);

  final String imageUrlAssets;
  final String textMessage;
  final bool isPostScreen;
  final Function()? onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: width,
          height: height,
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
      ),
    );
  }
}
