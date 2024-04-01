import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/model/chat_models/last_chats_model.dart';
import 'package:your_engineer/model/horizontal_profile.dart';
import 'package:your_engineer/screen/chat/chat_room_screen_222.dart';
import 'package:your_engineer/widget/shared_widgets/list_profile_horizontal.dart';

import '../../controller/profile_controller.dart';
import '../../enum/all_enum.dart';
import '../../widget/shared_widgets/bottom_navigation_card_widget.dart';
import '../../widget/shared_widgets/card_profile_personal_info.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import 'add_pro_skills_screen.dart';

class ProfileEngineerScreen extends StatefulWidget {
  const ProfileEngineerScreen(
      {Key? key,
      this.isFromHomeScreen = false,
      this.showEngeneerById = false,
      this.hidePersonalInfo = false,
      this.isPofileEng = false,
      required this.engeneerId})
      : super(key: key);
  // final TopEngineerRatingModel engineerModel;
  final String engeneerId;
  final bool showEngeneerById;
  final bool hidePersonalInfo;
  final bool isFromHomeScreen;
  final bool isPofileEng;

  @override
  State<ProfileEngineerScreen> createState() => _ProfileEngineerScreenState();
}

class _ProfileEngineerScreenState extends State<ProfileEngineerScreen> {
  ProfileUserController controller = Get.put(ProfileUserController());
  File? myfile;
  XFile? xfile;

  @override
  void initState() {
    getUsersShow();
    super.initState();
  }

  getUsersShow() async {
    controller
        .getUsersShow(widget.engeneerId)
        .then((value) => setState((() {})));
  }

  var profileList = [
    ListHorizontalProfile(
      AppConfig.personalProfile.tr,
      Icons.person,
      Icon(
        Icons.person,
        size: 22,
        color: Colors.white,
      ),
    ),

    // Image.asset(
    //       widget.listHorizontalProfile[index].image,
    //       width: 25,
    //       height: 25,
    //     )
    ListHorizontalProfile(
      AppConfig.reviews,
      Icons.star,
      Icon(
        Icons.star,
        size: 22,
        color: Colors.white,
      ),
    ),
    ListHorizontalProfile(
      AppConfig.businessFair.tr,
      Icons.badge,
      Icon(
        Icons.person,
        size: 22,
        color: Colors.white,
      ),
    ),
    ListHorizontalProfile(
      AppConfig.paymentHistory.tr,
      Icons.monetization_on_outlined,
      Icon(
        Icons.person,
        size: 22,
        color: Colors.white,
      ),
    ),
  ];

  var profileList2 = [
    ListHorizontalProfile(
      AppConfig.personalProfile.tr,
      Icons.person,
      Icon(
        Icons.person,
        size: 22,
        color: Colors.white,
      ),
    ),
    ListHorizontalProfile(
      AppConfig.reviews.tr,
      Icons.star,
      Icon(
        Icons.star,
        size: 22,
        color: Colors.white,
      ),
    ),
    ListHorizontalProfile(
      AppConfig.businessFair.tr,
      Icons.badge,
      Icon(
        Icons.badge,
        size: 22,
        color: Colors.white,
      ),
    ),
  ];
  int expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    log(widget.engeneerId.toString());
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () => getUsersShow().then((value) => setState((() {}))),
      child: Scaffold(
          backgroundColor: colorScheme.primary,
          body: Obx(() {
            if (controller.loadingState.value == LoadingState.initial ||
                controller.loadingState.value == LoadingState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (controller.loadingState.value == LoadingState.error ||
                controller.loadingState.value == LoadingState.noDataFound) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height / 30),
                  ReyTryErrorWidget(
                      title: controller.loadingState.value ==
                              LoadingState.noDataFound
                          ? AppConfig.noData.tr
                          : controller.message,
                      onTap: () {
                        controller.getUsersShow(widget.engeneerId);
                      })
                ],
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => getUsersShow(),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      CardProfilePersonalInfo(
                        isFromHomeScreen: widget.isFromHomeScreen,
                        userProfileModel: controller.userProfile,
                        isMyProfile: widget.engeneerId.isEmpty ? true : false,
                        hidePersonalInfo: widget.hidePersonalInfo,
                        size: size,
                        colorScheme: colorScheme,
                        onTap: () {
                          Get.to(() => const AddPortifolioSkillsScreen());
                        },
                      ),
                      SizedBox(height: Get.height * .03),
                      widget.isFromHomeScreen
                          ? Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: Get.width * .28),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ChatRoomScreen22222(
                                        showAllLink: true,
                                        userId: controller.userProfile.id,
                                        userEmail: controller.userProfile.email,
                                        chatsModel: Chats(
                                          receiverId: controller.userProfile.id,
                                          senderId: controller.userProfile.id,
                                          createdAt: "",
                                          id: "",
                                          message: "",
                                          messageType: "",
                                          recieverEmail: widget.engeneerId,
                                          recieverImg:
                                              controller.userProfile.imgpath,
                                          recieverName:
                                              controller.userProfile.fullname,
                                          senderImg: "",
                                          seqnum: 0,
                                          senderName: "",
                                          updatedAt: "",
                                          senderEmail:
                                              controller.userProfile.email,
                                          // image: resulte['client']['imgPath'],
                                          // receiverName: resulte['client']['fullname'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppConfig.chatEng.tr,
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        SizedBox(width: Get.width * .02),
                                        Icon(Icons.chat, color: Colors.green),
                                      ],
                                    ),
                                  )),
                            )
                          : const SizedBox(),
                      SizedBox(height: Get.height * .03),
                      ListProfileHorizontalWidget(
                        size: size,
                        colorScheme: colorScheme,
                        listHorizontalProfile: widget.hidePersonalInfo
                            ? profileList2
                            : profileList,
                        expandedIndex: expandedIndex,
                        onTap: ((index) {
                          setState(
                            () => expandedIndex = index,
                            //
                          );
                        }),
                      ),
                      BottomNavigationCardWidget(
                        userProfileModel: controller.userProfile,
                        size: size,
                        isPofileEng: widget.isPofileEng,
                        hidePersonalInfo: widget.hidePersonalInfo,
                        colorScheme: colorScheme,
                        expandedIndex: expandedIndex,
                        myfile: myfile,
                      ),
                    ],
                  ),
                )),
              );
            }
          })),
    );
  }
}
