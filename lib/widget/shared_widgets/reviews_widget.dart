import 'package:flutter/material.dart';

import '../../widget/shared_widgets/text_widget.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({Key? key, required this.size, required this.colorScheme})
      : super(key: key);
  final Size size;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          title: "No Reviews found",
          fontSize: 16,
          color: colorScheme.onSecondary,
          isTextStart: true,
        ),
        // buildRowReviews(
        //     "12  ${AppConfig.reviews}", AppConfig.seeAll, colorScheme),
        // const SizedBox(height: 10),
        // buildRowItem("House map design", "completed", colorScheme),
        // buildRowItem("Review", "5.0", colorScheme),
        // buildRowItem("Project completion date", "12/01/2022", colorScheme),
        // const Divider(),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 15, top: 15),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       const CircleAvatar(
        //         radius: 30.0,
        //         backgroundImage: AssetImage(AppImage.img2),
        //       ),
        //       const SizedBox(width: 10),
        //       TextWidget(
        //         title: "Mohammed Ali \n project owner",
        //         fontSize: 16,
        //         color: colorScheme.onSecondary,
        //       ),
        //     ],
        //   ),
        // ),
        // TextWidget(
        //   title: "Thank you very much for completing the project",
        //   fontSize: 16,
        //   color: colorScheme.onSecondary,
        //   isTextStart: true,
        // ),
        // const SizedBox(height: 20),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 15, top: 15),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       const CircleAvatar(
        //         radius: 30.0,
        //         backgroundImage: AssetImage(AppImage.img),
        //       ),
        //       const SizedBox(width: 10),
        //       TextWidget(
        //         title: "Yasser Abubaker \n engineer",
        //         fontSize: 16,
        //         color: colorScheme.onSecondary,
        //       ),
        //     ],
        //   ),
        // ),
        // TextWidget(
        //   title: "Thank you Mohammed Ali.",
        //   fontSize: 16,
        //   color: colorScheme.onSecondary,
        //   isTextStart: true,
        // ),
      ],
    );
  }
}

buildRowItem(String title, String description, ColorScheme colorScheme,
    {bool isPadingZero = false}) {
  return Padding(
    padding: EdgeInsets.only(bottom: isPadingZero ? 0 : 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          title: title,
          fontSize: 16,
          color: colorScheme.onSecondary,
        ),
        TextWidget(
          title: description,
          fontSize: 16,
          color: colorScheme.onSecondary,
        ),
      ],
    ),
  );
}

buildRowReviews(String title, String description, ColorScheme colorScheme) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          title: title,
          fontSize: 18,
          color: colorScheme.background,
        ),
        TextWidget(
          title: description,
          fontSize: 18,
          color: colorScheme.primary,
        ),
      ],
    ),
  );
}
