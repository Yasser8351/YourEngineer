import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/model/user_profile_model.dart';
import 'package:your_engineer/utilits/app_ui_helpers.dart';
import 'package:your_engineer/widget/shared_widgets/rating_bar.dart';

import '../../widget/shared_widgets/text_widget.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget(
      {Key? key,
      required this.size,
      required this.colorScheme,
      required this.talentreview})
      : super(key: key);
  final Size size;
  final ColorScheme colorScheme;
  final List<Talentreview> talentreview;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (talentreview.length == 0) ...[
            Padding(
              padding: EdgeInsets.only(top: Get.size.height * .23),
              child: TextWidget(
                title: AppConfig.noReviewsFound.tr,
                fontSize: px20,
                color: colorScheme.onSecondary,
                isTextStart: true,
              ),
            ),
          ] else
            buildRowReviews("${AppConfig.reviews.tr}   ${talentreview.length}",
                '', colorScheme),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: talentreview.length,
            itemBuilder: (context, index) => Column(
              children: [
                // verticalSpaceSemiLarge,
                buildRowItem(talentreview[index].project.projTitle,
                    AppConfig.completed.tr, colorScheme),
                Padding(
                  padding: EdgeInsets.only(bottom: px15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            NetworkImage(talentreview[index].owner.imgpath),
                      ),
                      const SizedBox(width: 10),
                      TextWidget(
                        title:
                            "${talentreview[index].owner.fullname} \n ${AppConfig.projectOwner.tr}",
                        fontSize: px16,
                        color: colorScheme.onSecondary,
                      ),
                      Spacer(),
                      buildRating(talentreview[index].starRate, colorScheme)
                    ],
                  ),
                ),
                TextWidget(
                  title: talentreview[index].comment,
                  fontSize: px16,
                  color: colorScheme.onSecondary,
                  isTextStart: true,
                ),
                SizedBox(height: px20),
                const Divider(),
                verticalSpaceRegular,
              ],
            ),
          )

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
      ),
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

buildRating(review_avg, ColorScheme colorScheme) {
  return // RatingBar
      Padding(
    padding: EdgeInsets.only(bottom: px20),
    child: Row(
      children: [
        RatingBar(
          sizeIcon: px15,
          color: Colors.amber,
          rating: double.parse(review_avg.toString()),
          onRatingChanged: (rating) {
            // setState(() => this.rating = rating)
          },
        ),
        const SizedBox(width: 7),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: TextWidget(
            title: review_avg.toString(),
            fontSize: px15,
            color: colorScheme.secondary,
          ),
        ),
      ],
    ),
  );
}
