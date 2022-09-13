import 'package:flutter/material.dart';
import 'package:your_engineer/model/top_engineer_rating_model.dart';
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {},
        height: 300,
        width: 210,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                topEngineerRatingModel.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextWidget(
                  title: topEngineerRatingModel.engineerName,
                  fontSize: 18,
                  color: colorScheme.onSecondary,
                  isTextStart: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: TextWidget(
                  title: topEngineerRatingModel.engineerspecialist,
                  fontSize: 18,
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
                      color: Colors.amber,
                      rating: topEngineerRatingModel.engineerRating,
                      onRatingChanged: (rating) {
                        // setState(() => this.rating = rating)
                      },
                    ),
                    const SizedBox(width: 7),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: TextWidget(
                        title: topEngineerRatingModel.engineerRating.toString(),
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
