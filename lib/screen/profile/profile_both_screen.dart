import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/model/horizontal_profile.dart';
import 'package:your_engineer/screen/profile/add_protofilo.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../controller/payment_account_controller.dart';
import '../../controller/profile_controller.dart';
import '../../enum/all_enum.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/bottom_navigation_card_widget.dart';
import '../../widget/shared_widgets/card_profile_personal_info.dart';
import '../../widget/shared_widgets/list_profile_horizontal.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';

class ProfileBothScreen extends StatefulWidget {
  const ProfileBothScreen({Key? key}) : super(key: key);

  @override
  State<ProfileBothScreen> createState() => _ProfileBothScreenState();
}

class _ProfileBothScreenState extends State<ProfileBothScreen> {
  ProfileUserController controller = Get.put(ProfileUserController());
  PaymentAccountsController paymentAccountsController =
      Get.put(PaymentAccountsController());

  var profileList = [
    ListHorizontalProfile(
      AppConfig.personalProfile,
      Icons.person,
      Icon(
        Icons.person,
        size: 22,
        color: Colors.white,
      ),
    ),
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
      AppConfig.businessFair,
      Icons.badge,
      Icon(
        Icons.person,
        size: 22,
        color: Colors.white,
      ),
    ),
    ListHorizontalProfile(
      AppConfig.paymentHistory,
      Icons.monetization_on_outlined,
      Icon(
        Icons.person,
        size: 22,
        color: Colors.white,
      ),
    ),
    ListHorizontalProfile(
      AppConfig.paypal,
      Icons.payment,
      image: AppImage.paypal,
      Image.asset(
        AppImage.paypal,
        width: 25,
        height: 25,
      ),
    ),
    ListHorizontalProfile(
      AppConfig.visa,
      Icons.visibility,
      image: AppImage.visa,
      Image.asset(
        AppImage.visa,
        width: 25,
        height: 25,
      ),
    ),
  ];

  int expandedIndex = 0;
  File? myfile;
  XFile? xfile;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: colorScheme.primary,
        body: SingleChildScrollView(
          child: Obx(() {
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
                  SizedBox(height: Get.height / 3.8),
                  ReyTryErrorWidget(
                      title: controller.loadingState.value ==
                              LoadingState.noDataFound
                          ? AppConfig.noData.tr
                          : controller.message,
                      onTap: () {
                        controller.getUsersShow('');
                      })
                ],
              );
            } else {
              return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                      CardProfilePersonalInfo(
                        userProfileModel: controller.userProfile,
                        isOwinr: true,
                        hidePersonalInfo: false,
                        size: size,
                        colorScheme: colorScheme,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AddProtofiloScreen()));
                        },
                      ),
                      const SizedBox(height: 35),
                      ListProfileHorizontalWidget(
                        size: size,
                        isPayScreen: true,
                        colorScheme: colorScheme,
                        listHorizontalProfile: profileList,
                        expandedIndex: expandedIndex,
                        onTap: ((index) {
                          setState(
                            () => expandedIndex = index,
                            //
                          );
                        }),
                      ),
                      SizedBox(height: Get.height * .01),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: TextWidget(

                            // isTextStart: true,
                            // isTextEnd: true,
                            title:
                                "${AppConfig.appCommissionIs.tr} ${controller.commission} ${AppConfig.dollar.tr} \n ${AppConfig.attachReceipt.tr}",
                            // "${AppConfig.appCommissionIs.tr} ${controller.commission} ${AppConfig.dollar.tr} \n ملحوظة : قم باجراء التحويلة ثم ارفق الاشعار",
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(paymentAccountsController.creditCardAccount),

                          Row(
                            children: [
                              TextWidget(
                                  title: expandedIndex == 4
                                      ? paymentAccountsController.emailAccount
                                      : expandedIndex == 5
                                          ? paymentAccountsController
                                              .creditCardAccount
                                          : "",
                                  fontSize: 16,
                                  color: Colors.white),
                              expandedIndex == 4 || expandedIndex == 5
                                  ? IconButton(
                                      onPressed: () async {
                                        Helper.showseuess(
                                            context: context,
                                            subtitle: "تم النسخ بنجاح");
                                        await Clipboard.setData(ClipboardData(
                                            text: expandedIndex == 4
                                                ? paymentAccountsController
                                                    .emailAccount
                                                : expandedIndex == 5
                                                    ? paymentAccountsController
                                                        .creditCardAccount
                                                    : ""));
                                        // copied successfully
                                      },
                                      icon: Icon(Icons.copy_all),
                                      color: Colors.white)
                                  : SizedBox(),
                            ],
                          ),
                          TextWidget(
                              title: expandedIndex == 4
                                  ? "Email Paypal"
                                  : expandedIndex == 5
                                      ? "Visa Account"
                                      : "",
                              fontSize: 16,
                              color: Colors.white),
                        ],
                      ),
                      BottomNavigationCardWidget(
                        userProfileModel: controller.userProfile,
                        size: size,
                        hidePersonalInfo: false,
                        colorScheme: colorScheme,
                        expandedIndex: expandedIndex,
                        myfile: myfile,
                        isoBoth: true,
                        widget: InkWell(
                          onTap: () async {
                            xfile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            // Navigator.of(context).pop();
                            myfile = File(xfile!.path);
                            setState(() {});
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            width: size.width * 1,
                            height: size.height * .18,
                            child: myfile != null
                                ? Image.file(
                                    myfile!,
                                    fit: BoxFit.fill,
                                  )
                                : Align(
                                    alignment: AlignmentDirectional.center,
                                    child: TextWidget(
                                        title: AppConfig.attachReceipt.tr +
                                            " " +
                                            AppConfig.here.tr,
                                        // "ملحوظة : قم باجراء التحويلة ثم ارفق الاشعار هنا",
                                        fontSize: 13,
                                        color: Colors.black),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
        ));
  }
}
