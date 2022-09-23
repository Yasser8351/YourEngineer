import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';
import 'package:your_engineer/widget/shared_widgets/reviews_widget.dart';

import '../../app_config/app_config.dart';
import '../../app_config/app_image.dart';
import '../../widget/shared_widgets/text_widget.dart';

class BottomNavigationCardWidget extends StatelessWidget {
  const BottomNavigationCardWidget({
    Key? key,
    required this.size,
    required this.colorScheme,
    required this.expandedIndex,
  }) : super(key: key);
  final Size size;
  final ColorScheme colorScheme;
  final int expandedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 0),
        child: CardWithImage(
          height: size.height * .7,
          width: size.width,
          colors: colorScheme.surface,
          isBorderRadiusTopLefZero: true,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 25),
            child: Builder(builder: (context) {
              if (expandedIndex == 1) {
                return ReviewsWidget(size: size, colorScheme: colorScheme);
              } else if (expandedIndex == 2) {
                return buildBusinessFair(colorScheme, size);
              } else if (expandedIndex == 3) {
                return buildPaymentHistory(colorScheme);
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: "About me",
                    fontSize: 18,
                    color: colorScheme.onSecondary,
                  ),
                  const SizedBox(height: 20),
                  TextWidget(
                    title:
                        "Architect with 2 more than years experience In the field of architectural and interior design.",
                    fontSize: 16,
                    color: colorScheme.onSecondary,
                    isTextStart: true,
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 20),
                  buildRowItem(
                      "Specialization", "Architectural engineer", colorScheme),
                  buildRowItem("Total Reviews", "5.0", colorScheme),
                  buildRowItem("Completed projects", "6", colorScheme),
                  buildRowItem("Projects he works on", "1", colorScheme),
                  buildRowItem(
                      "Date of registration", "12/02/2022", colorScheme),
                  const SizedBox(height: 10),
                  const Divider(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

buildBusinessFair(ColorScheme colorScheme, Size size) {
  return SingleChildScrollView(
    child: Column(
      children: [
        buildRowReviews(
            "4  ${AppConfig.project}", AppConfig.seeAll, colorScheme),
        const SizedBox(height: 10),
        Image.asset(
          AppImage.img5,
          height: 290,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 13),
        buildRowItem("Break design in Saudi Arabia", "12/01/2022", colorScheme),
        const SizedBox(height: 10),
        Image.asset(
          AppImage.img7,
          height: 290,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 13),
        buildRowItem("Gas station design", "07/09/2021", colorScheme),
        const SizedBox(height: 20),
      ],
    ),
  );
}

buildPaymentHistory(ColorScheme colorScheme) {
  return Column(
    children: [
      buildRowReviews(AppConfig.history, AppConfig.seeAll, colorScheme),
      const SizedBox(height: 10),
      buildRowItem("Shipped by PayPal", "\$250 -", colorScheme,
          isPadingZero: true),
      const SizedBox(height: 5),
      buildRowItem("yasser8351@gmail.com", "12/07/2022", colorScheme),
      const Divider(),
      const SizedBox(height: 20),
      buildRowItem("Profit from completing", "\$250 +", colorScheme,
          isPadingZero: true),
      const SizedBox(height: 5),
      buildRowItem(
          "an architectural design project", "09/01/2021", colorScheme),
      const Divider(),
      const SizedBox(height: 20),
      buildRowItem("Shipped by PayPal", "\$600 -", colorScheme,
          isPadingZero: true),
      const SizedBox(height: 5),
      buildRowItem("yasser8351@gmail.com", "01/10/2021", colorScheme),
      const Divider(),
    ],
  );
}
