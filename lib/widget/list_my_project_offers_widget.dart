// List Offers Engineer Widget

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/shared_widgets/accept_offer_or_chat_widget.dart';
import 'package:your_engineer/widget/shared_widgets/rating_bar.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../controller/accept_offer_controller.dart';
import '../enum/all_enum.dart';
import 'shared_widgets/card_decoration.dart';

class ListMyProjectOffersWidget extends StatelessWidget {
  const ListMyProjectOffersWidget(
      {Key? key,
      this.isMyProject = false,
      required this.resulte,
      required this.colorScheme,
      required this.size,
      required this.projectId,
      required this.projectStatus,
      required this.controller})
      : super(key: key);
  final String projectId;
  final dynamic resulte;
  final ColorScheme colorScheme;
  final Size size;
  final bool isMyProject;
  final ProjectStatus projectStatus;
  final AcceptOfferController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {},
        height: size.height * .39,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: colorScheme.primary,
                      backgroundImage:
                          NetworkImage(resulte['client']['imgPath'] ?? ""),
                    ),
                  ),
                  // SizedBox(height: size.height * .05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextWidget(
                          title: resulte['client']['fullname'],
                          fontSize: size.height * .022,
                          color: colorScheme.onSecondary,
                          isTextStart: false,
                        ),
                        TextWidget(
                          title: resulte['client']['userprofiles'] == null
                              ? ""
                              : resulte['client']['userprofiles']
                                      ['specialization']
                                  .toString(),
                          fontSize: size.height * .022,
                          color: colorScheme.onSecondary,
                          isTextStart: false,
                        ),

                        TextWidget(
                          title: GetTimeAgo.parse(
                              DateTime.parse(resulte['createdAt'] ?? ""),
                              pattern: "dd-MM-yyyy hh:mm aa",
                              locale: 'ar'),
                          // offersEngineerModel.offersDate,
                          fontSize: size.height * .022,

                          color: colorScheme.secondary,
                        ),
                        // RatingBar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBar(
                              sizeIcon: 15,
                              color: Colors.amber,
                              rating: 5,
                              // offersEngineerModel.engineerRating,
                              onRatingChanged: (rating) {
                                // setState(() => this.rating = rating)
                              },
                            ),
                            const SizedBox(width: 7),
                            TextWidget(
                              title: '5',
                              //  offersEngineerModel.engineerRating
                              //     .toString(),
                              fontSize: 15,
                              color: colorScheme.secondary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * .03),
              TextWidget(
                title:
                    AppConfig.price.tr + "         " + resulte['price'] + "\$",
                fontSize: size.height * .02,
                color: colorScheme.primary,
                isTextStart: true,
              ),
              TextWidget(
                title: AppConfig.daysToDeliver.tr +
                    " " +
                    resulte['days_to_deliver'].toString() +
                    " " +
                    AppConfig.dayProject.tr,
                fontSize: size.height * .02,
                color: colorScheme.primary,
                isTextStart: true,
              ),
              SizedBox(height: size.height * .02),
              TextWidget(
                title:
                    AppConfig.offerDetails.tr + " : " + resulte['message_desc'],
                //  offersEngineerModel.offersDetails,
                fontSize: size.height * .022,
                textOverflow: TextOverflow.ellipsis,

                color: colorScheme.onSecondary,
                isTextStart: true,
              ),
              SizedBox(height: size.height * .05),
              Builder(builder: (context) {
                if (projectStatus == ProjectStatus.open) {
                  return Obx(
                    () => AcceptOfferOrChatWidget(
                      isLoading: controller.isLoading.value,
                      senderId: resulte['client']['id'],
                      receiverId: resulte['client']['id'],
                      receiverEmail: resulte['client']['email'],
                      receiverName: resulte['client']['fullname'],
                      image: resulte['client']['imgPath'],
                      acceptOffer: (context) {
                        acceptOffer(
                          context,
                          controller,
                          offerId: resulte['id'],
                          projectId: projectId,
                          chatIdEng: resulte['client']['id'],
                        );
                      },
                    ),
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

  acceptOffer(BuildContext context, AcceptOfferController controller,
      {required String projectId,
      required String offerId,
      required String chatIdEng}) async {
    bool done = await controller.acceptOfferMyProject(
        context, projectId, offerId, chatIdEng);

    if (!done) {}
  }
}
