import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';
import 'package:your_engineer/widget/shared_widgets/reviews_widget.dart';
import 'package:intl/intl.dart';
import '../../app_config/app_image.dart';
import '../../controller/profile_controller.dart';
import '../../debugger/my_debuger.dart';
import '../../model/user_profile_model.dart';
import '../../screen/profile/add_skills_screen.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/text_widget.dart';

class BottomNavigationCardWidget extends StatefulWidget {
  const BottomNavigationCardWidget({
    Key? key,
    required this.size,
    required this.colorScheme,
    required this.expandedIndex,
    required this.hidePersonalInfo,
    required this.userProfileModel,
    required this.myfile,
    // required this.onTap,
    this.isowner = false,
    this.widget = null,
  }) : super(key: key);
  final Size size;
  final ColorScheme colorScheme;
  final int expandedIndex;
  final bool hidePersonalInfo;
  final UserProfileModel userProfileModel;
  final bool isowner;
  final File? myfile;
  final Widget? widget;
  // XFile? xfile;
  // final Function() onTap;

  @override
  State<BottomNavigationCardWidget> createState() =>
      _BottomNavigationCardWidgetState();
}

class _BottomNavigationCardWidgetState
    extends State<BottomNavigationCardWidget> {
  // File? myfile;
  // XFile? xfile;
  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    ProfileUserController controller = Get.put(ProfileUserController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 0),
        child: CardWithImage(
          height: widget.size.height * .7,
          width: widget.size.width,
          colors: widget.colorScheme.surface,
          isBorderRadiusTopLefZero: true,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 25),
            child: widget.isowner
                ? Builder(builder: (context) {
                    // if (widget.expandedIndex == 1||widget.expandedIndex == 2) {
                    //   return buildVisa(
                    //       widget.colorScheme, widget.size, controller, context);
                    // }
                    return buildPaypal(
                      widget.colorScheme,
                      widget.size,
                      controller,
                      context,
                      widget.myfile,
                      widget.widget,
                      // onTap: widget.onTap,
                    );
                  })
                : Builder(builder: (context) {
                    if (widget.expandedIndex == 1) {
                      return ReviewsWidget(
                          size: widget.size, colorScheme: widget.colorScheme);
                    } else if (widget.expandedIndex == 2) {
                      return buildBusinessFair(widget.colorScheme, widget.size,
                          widget.userProfileModel, locale);
                    } else if (widget.expandedIndex == 3) {
                      return buildPaymentHistory(widget.colorScheme);
                    }
                    return buildPersonalProfile(widget.colorScheme, widget.size,
                        widget.userProfileModel);
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

buildPaypal(
  ColorScheme colorScheme,
  Size size,
  ProfileUserController controller,
  BuildContext context,
  myfile,
  widget,
  // {required Function() onTap}
) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextWidget(
          title: 'اشعار التحويلة',
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
        SizedBox(height: size.height * .02),

        widget,
        SizedBox(height: size.height * .02),
        TextWidget(
          title: 'Amount',
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
        SizedBox(height: size.height * .02),
        buildTextFormFaild(
          controller.amountController,
          'Add Amount',
          false,
          TextInputType.number,
          const Icon(Icons.add),
          colorScheme,
          50,
          1,
        ),

        // SizedBox(height: size.height * .02),
        // TextWidget(
        //   title: 'Email',
        //   fontSize: 18,
        //   color: colorScheme.onSecondary,
        // ),
        // SizedBox(height: size.height * .02),
        // buildTextFormFaild(
        //   controller.emailController,
        //   'Add Your Email',
        //   false,
        //   TextInputType.text,
        //   const Icon(Icons.add),
        //   colorScheme,
        //   30,
        //   1,
        // ),
        // SizedBox(height: size.height * .02),

        //
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (controller.amountController.text.isEmpty) {
                Helper.showError(
                    context: context, subtitle: AppConfig.allFaildRequired.tr);
              } else {
                // setState(() => isLoading = true);

                bool isAddProject =
                    await controller.accountChargeRequest(context, myfile);
                // setState(() => isLoading = false);

                // if (isAddProject) {
                //   controller.clearController();
                //   Helper.showseuess(
                //       context: context,
                //       subtitle: AppConfig.addOfferSuccesfuly.tr);
                // } else {
                //   Helper.showError(
                //       context: context, subtitle: AppConfig.cannotaddOffer.tr);
                // }
              }
            },
            child: GetBuilder<ProfileUserController>(builder: (controller) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Center(
                  child: controller.isLoding
                      ? CircularProgressIndicator(color: Colors.white)
                      : TextWidget(
                          title: 'Send Data',
                          fontSize: 20,
                          color: colorScheme.surface),
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
}

buildVisa(ColorScheme colorScheme, Size size, ProfileUserController controller,
    BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: size.height * .02),

        TextWidget(
          title: 'Amount',
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
        SizedBox(height: size.height * .02),
        buildTextFormFaild(
          controller.amountVisaController,
          'Add Amount',
          false,
          TextInputType.text,
          const Icon(Icons.add),
          colorScheme,
          30,
          1,
        ),
        SizedBox(height: size.height * .02),
        TextWidget(
          title: 'Attachment',
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
        SizedBox(height: size.height * .02),
        buildTextFormFaild(
          controller.cardNumController,
          'Add Attachment',
          false,
          TextInputType.text,
          const Icon(Icons.add),
          colorScheme,
          30,
          1,
        ),
        SizedBox(height: size.height * .02),
        TextWidget(
          title: 'Name',
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
        SizedBox(height: size.height * .02),
        buildTextFormFaild(
          controller.cardNumController,
          'Add Your Name',
          false,
          TextInputType.text,
          const Icon(Icons.add),
          colorScheme,
          30,
          1,
        ),
        SizedBox(height: size.height * .02),
        TextWidget(
          title: 'Card Number',
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
        SizedBox(height: size.height * .02),
        buildTextFormFaild(
          controller.cardNumController,
          'Add Your Card Number',
          false,
          TextInputType.text,
          const Icon(Icons.add),
          colorScheme,
          30,
          1,
        ),
        SizedBox(height: size.height * .02),
        TextWidget(
          title: 'Expiration',
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
        SizedBox(height: size.height * .02),
        buildTextFormFaild(
          controller.expirationController,
          'Add Expiration',
          false,
          TextInputType.text,
          const Icon(Icons.add),
          colorScheme,
          30,
          1,
        ),
        SizedBox(height: size.height * .02),
        TextWidget(
          title: 'Email',
          fontSize: 18,
          color: colorScheme.onSecondary,
        ),
        SizedBox(height: size.height * .02),
        buildTextFormFaild(
          controller.emailController,
          'Add Your Email',
          false,
          TextInputType.text,
          const Icon(Icons.add),
          colorScheme,
          30,
          1,
        ),
        SizedBox(height: size.height * .02),

        //
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (controller.amountVisaController.text.isEmpty ||
                  controller.attachmentController.text.isEmpty ||
                  controller.nameController.text.isEmpty ||
                  controller.cardNumController.text.isEmpty ||
                  controller.expirationController.text.isEmpty) {
                Helper.showError(
                    context: context, subtitle: AppConfig.allFaildRequired.tr);
              } else {
                // setState(() => isLoading = true);

                bool isAddProject = await controller.addVisa(context);
                myLog('isAddProject', isAddProject);
                // setState(() => isLoading = false);

                if (isAddProject) {
                  controller.clearController();
                  Helper.showseuess(
                      context: context,
                      subtitle: AppConfig.addOfferSuccesfuly.tr);
                } else {
                  Helper.showError(
                      context: context, subtitle: AppConfig.cannotaddOffer.tr);
                }
              }
            },
            child: GetBuilder<ProfileUserController>(builder: (controller) {
              if (controller.statuse) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.white)),
                );
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: TextWidget(
                      title: 'Add your Paypal',
                      fontSize: 20,
                      color: colorScheme.surface),
                );
              }
            }),
          ),
        ),
        SizedBox(height: size.height * .06),
        // SizedBox(height: size.height * .02),
      ],
    ),
  );
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
                userProfileModel.userportfolio![index]!.createdAt!,
                // "${DateFormat('yyyy MM dd').format(userProfileModel.userportfolio![index]!.createdAt!))}",
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
