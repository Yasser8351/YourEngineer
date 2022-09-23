import 'package:flutter/material.dart';

import '../../app_config/app_image.dart';
import 'card_with_image.dart';
import 'text_widget.dart';

class CardProfilePersonalInfo extends StatelessWidget {
  const CardProfilePersonalInfo(
      {Key? key,
      required this.size,
      required this.colorScheme,
      required this.onTap})
      : super(key: key);
  final Size size;
  final ColorScheme colorScheme;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CardWithImage(
      height: size.height * .17,
      width: size.width,
      colors: colorScheme.surface,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        title: "Yasser Abubaker",
                        fontSize: 18,
                        color: colorScheme.onSecondary),
                    const SizedBox(height: 4),
                    TextWidget(
                        title: "yasser8351@gmail.com",
                        fontSize: 18,
                        color: colorScheme.onSecondary),
                    const SizedBox(height: 4),
                    TextWidget(
                        title: "Your balance \$200.0 ",
                        fontSize: 18,
                        color: colorScheme.onSecondary),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage(AppImage.img),
                    ),
                    const SizedBox(height: 7),
                    InkWell(
                      onTap: onTap,
                      child: CircleAvatar(
                        radius: 13.0,
                        backgroundColor: colorScheme.primary,
                        child: Icon(
                          Icons.add,
                          color: colorScheme.surface,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
