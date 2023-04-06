// ListOffersEngineerWidget

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/controller/offers_controller.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/screen/chat/chat_room_screen.dart';
import 'package:your_engineer/utilits/helper.dart';
import 'package:your_engineer/widget/shared_widgets/loading_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';
import 'shared_widgets/card_decoration.dart';

class ListOffersEngineerWidget extends StatelessWidget {
  const ListOffersEngineerWidget(
      {Key? key,
      required this.resulte,
      required this.index,
      required this.offerController,
      required this.colorScheme,
      required this.size})
      : super(key: key);
  final dynamic resulte;
  final ColorScheme colorScheme;
  final Size size;
  final OfferController offerController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {},
        height: size.height * .3,
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
                      radius: 45.0,
                      backgroundColor: colorScheme.primary,
                      backgroundImage:
                          NetworkImage(resulte['client']['imgPath'].toString()),
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
                          title: '', // engineerspecialist
                          fontSize: 18,
                          color: colorScheme.secondary,
                          isTextStart: true,
                        ),
                      ),
                      SizedBox(height: size.height * .01),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  title: AppConfig.price.tr,
                                  fontSize: 15,
                                  color: colorScheme.secondary,
                                ),
                                const SizedBox(width: 7),
                                TextWidget(
                                  title: resulte['price'].toString(),
                                  fontSize: 15,
                                  color: colorScheme.secondary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * .01),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  title: AppConfig.daysToDeliver.tr,
                                  fontSize: 15,
                                  color: colorScheme.secondary,
                                ),
                                const SizedBox(width: 7),
                                TextWidget(
                                  title: resulte['days_to_deliver'].toString(),
                                  fontSize: 15,
                                  color: colorScheme.secondary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * .01),

                      // Row(
                      //   children: [
                      //     // RatingBar
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 10),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           RatingBar(
                      //             sizeIcon: 15,
                      //             color: Colors.amber,
                      //             rating: 3.5,
                      //             //  offersEngineerModel.engineerRating,
                      //             onRatingChanged: (rating) {
                      //               // setState(() => this.rating = rating)
                      //             },
                      //           ),
                      //           const SizedBox(width: 7),
                      //           TextWidget(
                      //             title: '3.5',
                      //             //  offersEngineerModel.engineerRating
                      //             //     .toString(),
                      //             fontSize: 15,
                      //             color: colorScheme.secondary,
                      //           ),
                      //         ],
                      //       ),
                      //     ),

                      //   ],
                      // ),
                      TextWidget(
                        title: dateFormat(resulte['createdAt']),
                        fontSize: 18,
                        color: colorScheme.secondary,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * .02),
              Container(
                height: size.height * .06,
                child: TextWidget(
                  textOverflow: TextOverflow.ellipsis,
                  title: resulte['message_desc'],
                  fontSize: 18,
                  color: colorScheme.onSecondary,
                  isTextStart: true,
                ),
              ),

              // SizedBox(height: size.height * .01),

              if (offerController.isProjectOwner == 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    offerController.loadingState == LoadingState.loading
                        ? LoadingWidget()
                        : ElevatedButton(
                            onPressed: () async => acceptOffer(context),
                            child: Text(
                              "قبول العرض",
                              style: TextStyle(color: Colors.white),
                            )),
                    SizedBox(width: 30),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(ChatRoomScreen(
                            receiverId: '',
                            receiverEmail: '',
                          ));
                        },
                        child: Text(
                          "محادثة",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  acceptOffer(BuildContext context) async {
    bool done = await offerController.acceptOffer(
        context, resulte['id'], offerController.offerId[index]['id']);

    if (!done) {
      offerController.getProjectsById(resulte['id'], index);
    }
  }
}
