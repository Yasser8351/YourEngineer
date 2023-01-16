// ListOffersEngineerWidget

import 'package:flutter/material.dart';
import 'package:your_engineer/model/offers_engineer_model.dart';
import 'package:your_engineer/widget/shared_widgets/rating_bar.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import 'shared_widgets/card_decoration.dart';

class ListOffersEngineerWidget extends StatelessWidget {
  const ListOffersEngineerWidget(
      {Key? key,
      required this.resulte,
      required this.colorScheme,
      required this.size})
      : super(key: key);
  final dynamic resulte;
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
        height: size.height * .4,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: colorScheme.primary,
                      // backgroundImage: AssetImage(
                      //   offersEngineerModel.imageEngineer,
                      // ),
                    ),
                  ),
                  SizedBox(height: size.height * .05),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextWidget(
                          title: resulte['client']['fullname'],
                          fontSize: 18,
                          color: colorScheme.onSecondary,
                          isTextStart: false,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: TextWidget(
                          title: 'engineerspecialist',
                          // offersEngineerModel.engineerspecialist,
                          fontSize: 18,
                          color: colorScheme.secondary,
                          isTextStart: true,
                        ),
                      ),
                      Row(
                        children: [
                          // RatingBar
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBar(
                                  sizeIcon: 15,
                                  color: Colors.amber,
                                  rating: 3.5,
                                  //  offersEngineerModel.engineerRating,
                                  onRatingChanged: (rating) {
                                    // setState(() => this.rating = rating)
                                  },
                                ),
                                const SizedBox(width: 7),
                                TextWidget(
                                  title: '3.5',
                                  //  offersEngineerModel.engineerRating
                                  //     .toString(),
                                  fontSize: 15,
                                  color: colorScheme.secondary,
                                ),
                              ],
                            ),
                          ),

                          TextWidget(
                            title: resulte['createdAt'],
                            // offersEngineerModel.offersDate,
                            fontSize: 18,
                            color: colorScheme.secondary,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * .05),
              TextWidget(
                title: resulte['message_desc'],
                //  offersEngineerModel.offersDetails,
                fontSize: 18,
                color: colorScheme.onSecondary,
                isTextStart: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
