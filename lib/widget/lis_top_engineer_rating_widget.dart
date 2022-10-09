import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/model/top_engineer_rating_model.dart';
import 'package:your_engineer/screen/profile/profile_engineer_screen.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';
import 'package:your_engineer/widget/shared_widgets/my_favorite_button.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import 'shared_widgets/card_decoration.dart';
import 'shared_widgets/rating_bar.dart';

class ListTopEngineerRatingWidget extends StatelessWidget {
  const ListTopEngineerRatingWidget(
      {Key? key,
      required this.topEngineerRatingModel,
      required this.colorScheme,
      required this.size})
      : super(key: key);
  final TopEngineerRatingModel topEngineerRatingModel;
  final ColorScheme colorScheme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return CardDecoration(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfileEngineerScreen(
                  engineerModel: topEngineerRatingModel,
                  // colorScheme: colorScheme,
                  // size: size,
                )));
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
              // Image.network(
              //   topEngineerRatingModel.user.imgPath,
              //   height: size.height * .2,
              //   width: double.infinity,
              //   fit: BoxFit.fill,
              // ),
              Image.asset(
                AppImage.img11,
                height: size.height * .2,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: topEngineerRatingModel.user.fullname,
                      fontSize: 18,
                      color: colorScheme.onSecondary,
                      isTextStart: false,
                    ),
                    CardWithImage(
                        colors: Colors.green.shade50,
                        onTap: () {},
                        height: 35,
                        width: 35,
                        child: MyFavoriteButton(
                          iconSize: 35,
                          iconColor: Colors.red,
                          isFavorite: false,
                          valueChanged: (isFavorite) async {},
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: TextWidget(
                  title: topEngineerRatingModel.specialization,
                  fontSize: 16,
                  color: colorScheme.secondary,
                  isTextStart: true,
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
                      rating: 4.5,
                      // rating: topEngineerRatingModel.user.rating,
                      onRatingChanged: (rating) {
                        // setState(() => this.rating = rating)
                      },
                    ),
                    const SizedBox(width: 7),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: TextWidget(
                        title: 4.5.toString(),
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
