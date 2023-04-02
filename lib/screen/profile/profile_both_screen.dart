import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/model/horizontal_profile.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../controller/payment_account_controller.dart';
import '../../controller/profile_controller.dart';
import '../../enum/all_enum.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/bottom_navigation_card_widget.dart';
import '../../widget/shared_widgets/card_profile_personal_info.dart';
import '../../widget/shared_widgets/list_profile_horizontal.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  ProfileUserController controller = Get.put(ProfileUserController());
  PaymentAccountsController paymentAccountsController =
      Get.put(PaymentAccountsController());

  var profileList = [
    ListHorizontalProfile(AppConfig.paypal, Icons.payment,
        image: AppImage.paypal),
    ListHorizontalProfile(AppConfig.visa, Icons.visibility,
        image: AppImage.visa),
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
                        hidePersonalInfo: true,
                        size: size,
                        colorScheme: colorScheme,
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const AddProtofiloScreen()));
                        },
                      ),
                      const SizedBox(height: 35),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextWidget(
                            title:
                                "${controller.commission} عمولة التطبيق هي /n ملحوظة : قم باجراء التحويلة ثم ارفق الاشعار",
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      ListProfileHorizontalWidget(
                        isPayScreen: true,
                        size: size,
                        colorScheme: colorScheme,
                        listHorizontalProfile: profileList,
                        expandedIndex: expandedIndex,
                        onTap: ((index) {
                          setState(() => expandedIndex = index);
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(paymentAccountsController.creditCardAccount),

                          Row(
                            children: [
                              TextWidget(
                                  title: expandedIndex == 0
                                      ? paymentAccountsController.emailAccount
                                      : paymentAccountsController
                                          .creditCardAccount,
                                  fontSize: 16,
                                  color: Colors.white),
                              IconButton(
                                  onPressed: () async {
                                    Helper.showseuess(
                                        context: context,
                                        subtitle: "تم النسخ بنجاح");
                                    await Clipboard.setData(ClipboardData(
                                        text: expandedIndex == 0
                                            ? paymentAccountsController
                                                .emailAccount
                                            : paymentAccountsController
                                                .creditCardAccount));
                                    // copied successfully
                                  },
                                  icon: Icon(Icons.copy_all),
                                  color: Colors.white),
                            ],
                          ),
                          TextWidget(
                              title: expandedIndex == 0
                                  ? "Email Paypal"
                                  : "Visa Account",
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
                        isowner: true,
                        myfile: myfile,
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
                                    alignment: Alignment.center,
                                    child: TextWidget(
                                        title:
                                            "ملحوظة : قم باجراء التحويلة ثم ارفق الاشعار هنا",
                                        fontSize: 13,
                                        color: Colors.black),
                                  ),
                          ),
                        ),
                        // onTap: () async {
                        //   xfile = await ImagePicker()
                        //       .pickImage(source: ImageSource.gallery);
                        //   // Navigator.of(context).pop();
                        //   log(myfile!.path);

                        //   myfile = File(xfile!.path);
                        //   setState(() {});
                        // },
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
