import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';
import 'package:your_engineer/widget/shared_widgets/reviews_widget.dart';
import 'package:intl/intl.dart';
import '../../app_config/app_image.dart';
import '../../model/user_profile_model.dart';
import '../../widget/shared_widgets/text_widget.dart';

class BottomNavigationCardWidget extends StatelessWidget {
  const BottomNavigationCardWidget({
    Key? key,
    required this.size,
    required this.colorScheme,
    required this.expandedIndex,
    required this.hidePersonalInfo,
    required this.userProfileModel,
  }) : super(key: key);
  final Size size;
  final ColorScheme colorScheme;
  final int expandedIndex;
  final bool hidePersonalInfo;
  final UserProfileModel userProfileModel;

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;

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
                return buildBusinessFair(
                    colorScheme, size, userProfileModel, locale);
              } else if (expandedIndex == 3) {
                return buildPaymentHistory(colorScheme);
              }
              return buildPersonalProfile(colorScheme, size, userProfileModel);
            }),
          ),
        ),
      ),
    );
  }
}

buildPersonalProfile(
    ColorScheme colorScheme, Size size, UserProfileModel userProfileModel) {
  //
  return SingleChildScrollView(
      child: Column(
    children: [
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: TextWidget(
          title: AppConfig.aboutme,
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
      ),
      const SizedBox(height: 20),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: TextWidget(
          title: userProfileModel.userprofiles!.aboutUser,
          fontSize: 16,
          color: colorScheme.onSecondary,
          isTextStart: true,
        ),
      ),
      const SizedBox(height: 10),
      const Divider(),
      const SizedBox(height: 20),
      buildRowItem("Specialization",
          userProfileModel.userprofiles!.specialization, colorScheme),
      buildRowItem("Total Reviews", userProfileModel.review_avg!, colorScheme),
      buildRowItem("Completed projects", "6", colorScheme),
      buildRowItem("Projects he works on", "1", colorScheme),
      buildRowItem("Date of registration", "12/02/2022", colorScheme),
      // const SizedBox(height: 10),

      const Divider(),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: TextWidget(
          title: AppConfig.skills,
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
      ),
      const SizedBox(height: 10),
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 200),
        itemCount: userProfileModel.userskills!.length,
        itemBuilder: ((context, index) => Container(
              // height: 10,
              // width: 10,
              child: Text("${userProfileModel.userskills![index]!.skillName}"),
            )),
      ),
      const SizedBox(height: 30),
    ],
  ));
  //
}

buildBusinessFair(ColorScheme colorScheme, Size size,
    UserProfileModel userProfileModel, String locale) {
  log(userProfileModel.userportfolio!.length.toString());
  dynamic d = DateFormat('yyyy MM dd').format(DateTime.now());

  return SingleChildScrollView(
      child: Column(
    children: [
      buildRowReviews(
          "Project ${userProfileModel.userportfolio!.length}", "", colorScheme),
      ListView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: userProfileModel.userportfolio!.length,
        itemBuilder: (context, index) => Column(
          children: [
            const Divider(),
            Image.asset(
              AppImage.img5,
              height: 290,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 13),

            buildRowReviews(
                "${userProfileModel.userportfolio![index]!.title}",
                "${DateFormat('yyyy MM dd').format((userProfileModel.userportfolio![index]!.createdAt!))}",
                colorScheme),
            // DateTime.now.,
            const SizedBox(height: 10),
          ],
        ),
      ),
      const SizedBox(height: 30),
    ],
  ));
}

buildPaymentHistory(ColorScheme colorScheme) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextWidget(
        title: "No Payment History found",
        fontSize: 16,
        color: colorScheme.onSecondary,
        isTextStart: true,
      ),
      /*
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
      const Divider(),*/
    ],
  );
}
