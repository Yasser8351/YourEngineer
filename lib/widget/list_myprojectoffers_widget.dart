// List Offers Engineer Widget

import 'package:flutter/material.dart';
import 'package:your_engineer/controller/myprojectoffers_screen_controller.dart';
import 'package:your_engineer/widget/shared_widgets/accept_offer_or_chat_widget.dart';
import 'package:your_engineer/widget/shared_widgets/rating_bar.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../enum/all_enum.dart';
import '../utilits/helper.dart';
import 'shared_widgets/card_decoration.dart';

class ListMyProjectOffersWidget extends StatelessWidget {
  const ListMyProjectOffersWidget(
      {Key? key,
      this.isMyProject = false,
      required this.resulte,
      required this.colorScheme,
      required this.size,
      required this.projectStatus,
      required this.controller})
      : super(key: key);
  final dynamic resulte;
  final ColorScheme colorScheme;
  final Size size;
  final bool isMyProject;
  final ProjectStatus projectStatus;
  final MyProjectOffersScreenController controller;

  @override
  Widget build(BuildContext context) {
    // myLog(resulte['id'], resulte['client']['id']);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {},
        height: size.height * .38,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: colorScheme.primary,
                      // backgroundImage: AssetImage(
                      //   offersEngineerModel.imageEngineer,
                      // ),
                    ),
                  ),
                  // SizedBox(height: size.height * .05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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

                      TextWidget(
                        title: dateFormat(resulte['createdAt']),
                        // offersEngineerModel.offersDate,
                        fontSize: 18,
                        color: colorScheme.secondary,
                      ),
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
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * .05),
              TextWidget(
                title: resulte['message_desc'],
                //  offersEngineerModel.offersDetails,
                fontSize: 18,
                textOverflow: TextOverflow.ellipsis,

                color: colorScheme.onSecondary,
                isTextStart: true,
              ),
              SizedBox(height: size.height * .05),
              Builder(builder: (context) {
                if (projectStatus == ProjectStatus.open) {
                  return AcceptOfferOrChatWidget(
                    isLoading: false,
                    acceptOffer: (context) {
                      acceptOffer(context, controller);
                    },
                  );
                } else {
                  return SizedBox();
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  acceptOffer(
      BuildContext context, MyProjectOffersScreenController controller) async {
    bool done = await controller.acceptOffer(
        context, resulte['id'], resulte['client']['id']);

    if (!done) {
      // offerController.getProjectsById(resulte['id'], index);
    }
  }
}
