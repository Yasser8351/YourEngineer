// ListOffersEngineerWidget

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/controller/offers_controller.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/model/chat_models/last_chats_model.dart';

import 'package:your_engineer/screen/chat/chat_room_screen_222.dart';
import 'package:your_engineer/sharedpref/user_share_pref.dart';
import 'package:your_engineer/widget/shared_widgets/loading_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';
import 'shared_widgets/card_decoration.dart';

class ListOffersEngineerWidget extends StatefulWidget {
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
  State<ListOffersEngineerWidget> createState() =>
      _ListOffersEngineerWidgetState();
}

class _ListOffersEngineerWidgetState extends State<ListOffersEngineerWidget> {
  String email = "";
  String userId = "";

  @override
  void initState() {
    myLog("resulte resulte", widget.resulte);
    super.initState();
    getEmail();
  }

  getEmail() async {
    SharedPrefUser prefs = SharedPrefUser();
    String _email = await prefs.getEmail();
    String _id = await prefs.getId();

    setState(() {
      email = _email;
      userId = _id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {},
        height: widget.size.height * .28,
        width: widget.size.width,
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
                      backgroundColor: widget.colorScheme.primary,
                      backgroundImage: NetworkImage(
                          widget.resulte['client']['imgPath'].toString()),
                    ),
                  ),
                  SizedBox(height: widget.size.height * .05),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextWidget(
                          title: widget.resulte['client']['fullname'],
                          fontSize: Get.height * .022,
                          color: widget.colorScheme.onSecondary,
                          isTextStart: false,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: TextWidget(
                          title: '', // engineerspecialist
                          fontSize: Get.height * .02,

                          color: widget.colorScheme.secondary,
                          isTextStart: true,
                        ),
                      ),
                      SizedBox(height: widget.size.height * .01),

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
                                  fontSize: Get.height * .02,
                                  color: widget.colorScheme.secondary,
                                ),
                                const SizedBox(width: 7),
                                TextWidget(
                                  title:
                                      "\$" + widget.resulte['price'].toString(),
                                  fontSize: Get.height * .02,
                                  color: widget.colorScheme.secondary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: widget.size.height * .01),

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
                                  color: widget.colorScheme.secondary,
                                ),
                                const SizedBox(width: 7),
                                TextWidget(
                                  title: widget.resulte['days_to_deliver']
                                      .toString(),
                                  fontSize: 15,
                                  color: widget.colorScheme.secondary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: widget.size.height * .01),

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
                        title: GetTimeAgo.parse(
                            DateTime.parse(widget.resulte['createdAt'] ?? ""),
                            pattern: "dd-MM-yyyy hh:mm aa",
                            locale: 'ar'),
                        fontSize: Get.height * .02,
                        color: widget.colorScheme.secondary,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: widget.size.height * .02),
              Container(
                height: widget.size.height * .06,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: TextWidget(
                    textOverflow: TextOverflow.ellipsis,
                    title: widget.resulte['message_desc'],
                    fontSize: Get.height * .02,
                    color: widget.colorScheme.onSecondary,
                    isTextStart: true,
                  ),
                ),
              ),

              // SizedBox(height: size.height * .01),

              if (widget.offerController.isProjectOwner == 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    widget.offerController.loadingState == LoadingState.loading
                        ? LoadingWidget()
                        : ElevatedButton(
                            onPressed: () async => acceptOffer(context),
                            child: Text(
                              AppConfig.acceptOffer.tr,
                              style: TextStyle(color: Colors.white),
                            )),
                    SizedBox(width: 30),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(ChatRoomScreen22222(
                            userId: userId,
                            userEmail: email,
                            chatsModel: Chats(
                              receiverId: widget.resulte['client']['id'],
                              senderId: userId,
                              createdAt: "",
                              id: "",
                              message: "",
                              messageType: "",
                              recieverEmail: widget.resulte['client']['email'],
                              recieverImg: widget.resulte['client']['imgPath'],
                              recieverName: widget.resulte['client']
                                  ['fullname'],
                              senderImg: "",
                              seqnum: 0,
                              senderName: "",
                              updatedAt: "",
                              senderEmail: email,
                              // image: resulte['client']['imgPath'],
                              // receiverName: resulte['client']['fullname'],
                            ),
                          ));
                        },
                        child: Text(
                          AppConfig.chatEng.tr,
                          // "محادثة",
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
    bool done = await widget.offerController.acceptOffer(
        context,
        widget.resulte['id'],
        widget.offerController.offerId[widget.index]['id']);

    if (!done) {
      widget.offerController
          .getProjectsById(widget.resulte['id'], widget.index);
    }
  }
}
