import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:your_engineer/widget/shared_widgets/full_image.dart';
import '../../model/user_profile_model.dart';
import 'card_with_image.dart';
import 'rating_bar.dart';
import 'text_widget.dart';

class CardProfilePersonalInfo extends StatelessWidget {
  const CardProfilePersonalInfo({
    Key? key,
    required this.size,
    required this.colorScheme,
    required this.onTap,
    this.isMyProfile = true,
    this.isOwinr = false,
    this.hidePersonalInfo = false,
    required this.userProfileModel,
  }) : super(key: key);
  final Size size;
  final ColorScheme colorScheme;
  final Function() onTap;
  final isMyProfile;
  final bool isOwinr;
  final hidePersonalInfo;
  final UserProfileModel userProfileModel;

  @override
  Widget build(BuildContext context) {
    // final _shared = SharedPrefUser();

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
                        title: userProfileModel.fullname!,
                        // userModel.fullName,
                        fontSize: 18,
                        color: colorScheme.onSecondary),
                    const SizedBox(height: 4),
                    TextWidget(
                        title: userProfileModel.email!,
                        // userModel.email,
                        fontSize: 18,
                        color: colorScheme.onSecondary),
                    const SizedBox(height: 4),
                    TextWidget(
                        title: isOwinr ? "صاحب مشاريع" : "مهندس",
                        // userModel.email,
                        fontSize: 18,
                        color: colorScheme.onSecondary),
                    const SizedBox(height: 4),
                    isOwinr
                        ? // RatingBar
                        TextWidget(
                            title: "Your balance \$0.0 ",
                            fontSize: 18,
                            color: colorScheme.onSecondary)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RatingBar(
                                color: Colors.amber,
                                rating: 4.5,
                                sizeIcon: 22,
                                onRatingChanged: (rating) {
                                  // setState(() => this.rating = rating)
                                },
                              ),
                              const SizedBox(width: 7),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: TextWidget(
                                  title: 4.5.toString(),
                                  fontSize: 17,
                                  color: colorScheme.onSecondary,
                                ),
                              ),
                            ],
                          )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Get.to(
                          () => FullImage(imageUrl: userProfileModel.imgpath!)),
                      child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          backgroundImage:
                              NetworkImage(userProfileModel.imgpath!)
                          // backgroundImage: AssetImage(
                          //     isMyProfile ? AppImage.img : AppImage.img11),
                          ),
                    ),
                    const SizedBox(height: 7),
                    hidePersonalInfo
                        ? SizedBox()
                        : InkWell(
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
