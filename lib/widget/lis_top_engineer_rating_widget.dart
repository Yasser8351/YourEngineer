import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:your_engineer/app_config/api_url.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/model/top_engineer_rating_model.dart';
import 'package:your_engineer/screen/profile/profile_engineer_screen.dart';
import 'package:your_engineer/widget/shared_widgets/image_network.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import 'shared_widgets/card_decoration.dart';
import 'shared_widgets/rating_bar.dart';

class ListTopEngineerRatingWidget extends StatelessWidget {
  const ListTopEngineerRatingWidget(
      {Key? key,
      this.isFromHomeScreen = false,
      this.fit = BoxFit.fill,
      required this.topEngineerRatingModel,
      required this.colorScheme,
      required this.size})
      : super(key: key);
  final Result topEngineerRatingModel;
  final ColorScheme colorScheme;
  final Size size;
  final bool isFromHomeScreen;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    myLog(topEngineerRatingModel, topEngineerRatingModel);
    return CardDecoration(
      onTap: () {
        Get.to(() => ProfileEngineerScreen(
            engeneerId: topEngineerRatingModel.id,
            isFromHomeScreen: isFromHomeScreen));
        // Get.to(() => ChatRoomScreen(
        //       receiverId: topEngineerRatingModel.id,
        //       receiverEmail: topEngineerRatingModel.email,
        //       receiverName: topEngineerRatingModel.fullname,
        //       image: topEngineerRatingModel.imgPath,
        //       senderId: topEngineerRatingModel.id,
        //     ));
      },
      height: 0,
      width: size.width * .6,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCached(
                image: ApiUrl.imageUrl + topEngineerRatingModel.imgPath,
                // ApiUrl.root + "/" + populerServicesModel.imageUrlServices,
                height: Get.height * .16,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      // title: "",
                      title: topEngineerRatingModel.fullname,
                      fontSize: 18,
                      color: colorScheme.onSecondary,
                      isTextStart: false,
                    ),
                  ],
                ),
              ),

              // RatingBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    RatingBar(
                      sizeIcon: 15,
                      color: Colors.amber,
                      rating: 5,
                      // rating: topEngineerRatingModel.user.rating,
                      onRatingChanged: (rating) {
                        // setState(() => this.rating = rating)
                      },
                    ),
                    const SizedBox(width: 7),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: TextWidget(
                        title: 5.toString(),
                        // title: topEngineerRatingModel.engineerRating.toString(),
                        fontSize: 15,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
