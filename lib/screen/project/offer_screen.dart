import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/screen/pdf_screen.dart';
import 'package:your_engineer/utilits/app_ui_helpers.dart';
import 'package:your_engineer/widget/shared_widgets/full_image.dart';
import 'package:your_engineer/widget/shared_widgets/no_data.dart';
import 'package:your_engineer/widget/shared_widgets/row_two_with_text.dart';

import '../../app_config/app_config.dart';
import '../../controller/offers_controller.dart';
import '../../enum/all_enum.dart';
import '../../utilits/helper.dart';
import '../../widget/list_offers_engineer_widget.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';
import '../profile/profile_engineer_screen.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({
    Key? key,
    // required this.index,
  }) : super(key: key);
  // final int index;

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  OfferController controller = Get.find();

  bool isLoading = false;
  bool isAddProject = false;
  int priceRange = 0;
  @override
  initState() {
    Future.delayed(Duration.zero, () {
      trimPrice();
    });
    super.initState();
  }

  trimPrice() {
    /// range_name: 50 - 100}
    String str =
        controller.results['PriceRange']['range_name'].toString().trim();
    const start = "";
    const end = "-";

    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);
    var sub = str.substring(startIndex + start.length, endIndex);
    priceRange = int.parse(sub);

    log("priceRange  $priceRange");
    return sub;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: _getAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .025),
                  child: Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * .03),
                        TextWidget(
                            title: "${AppConfig.projectTitle.tr} :",
                            fontSize: size.height * .018,
                            color: colorScheme.background),
                        SizedBox(height: size.height * .02),
                        TextWidget(
                            title: controller.results['proj_title'],
                            fontSize: size.height * .018,
                            color: colorScheme.primary),
                        SizedBox(height: size.height * .02),
                        TextWidget(
                            title: "${AppConfig.projectDetails.tr} :",
                            fontSize: size.height * .018,
                            color: colorScheme.background),
                        SizedBox(height: size.height * .02),
                        TextWidget(
                          title: controller.results['proj_description'],
                          fontSize: size.height * .018,
                          color: colorScheme.primary,
                          isTextStart: true,
                        ),
                        SizedBox(height: size.height * .031),

                        controller.results['attatchment_file'] != null
                            ? InkWell(
                                onTap: () => controller
                                        .results['attatchment_file']
                                        .toString()
                                        .contains('pdf')
                                    ? Get.to(() => PDFScreen(
                                        filePath: controller
                                            .results['attatchment_file']
                                            .toString()))
                                    : Get.to(() => FullImage(
                                        imageUrl: controller
                                            .results['attatchment_file']
                                            .toString())),
                                child: TextWidget(
                                  title: controller.results['attatchment_file']
                                      .toString(),
                                  fontSize: size.height * .015,
                                  color: Colors.blue,
                                  isTextStart: true,
                                ),
                              )
                            : SizedBox(),
                        SizedBox(height: size.height * .031),
                        Row(
                          children: [
                            buildRowText(
                                AppConfig.priceRange.tr,
                                controller.results['PriceRange']['range_name'],
                                size,
                                colorScheme),
                            SizedBox(width: 3),
                            TextWidget(
                                title: "\$",
                                fontSize: Get.height * .018,
                                color: colorScheme.primary)
                          ],
                        ),
                        SizedBox(height: size.height * .031),
                        buildRowText(
                            AppConfig.offerCount.tr,
                            controller.results['OffersCount'].toString(),
                            size,
                            colorScheme),
                        SizedBox(height: size.height * .031),
                        buildRowText(
                            AppConfig.dateProject.tr,
                            controller.results['proj_period'].toString() +
                                " " +
                                AppConfig.day.tr,
                            size,
                            colorScheme),

                        // buildRowText(
                        //   "ملفات مرفقة",
                        //   controller.results['attatchment_file'].toString(),
                        //   size,
                        //   colorScheme,
                        // ),
                        SizedBox(height: size.height * .031),
                        controller.results['skills'].toString().isEmpty
                            ? const SizedBox()
                            : buildRowText(
                                AppConfig.skills.tr,
                                controller.results['skills'],
                                size,
                                colorScheme),
                        SizedBox(height: size.height * .03),
                      ],
                    ),
                  ),
                )),

                SizedBox(height: size.height * .05),
                const Divider(),
                SizedBox(height: px10),
                TextWidget(
                  title: AppConfig.allOffer.tr,
                  fontSize: size.width * .052,
                  color: colorScheme.primary,
                  isTextStart: false,
                ),
                SizedBox(height: size.height * .01),

                Builder(builder: (context) {
                  return Obx(
                    () {
                      if (controller.loadingProject.value ==
                              LoadingState.initial ||
                          controller.loadingProject.value ==
                              LoadingState.loading)
                        return Center(child: CircularProgressIndicator());
                      else if (controller.userOfferCount > 0 ||
                          controller.isProjectOwner == 1 ||
                          controller.typeAccount.contains('OWNER')) {
                        return SizedBox();
                      } else
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isAddProject
                                ? SizedBox()
                                : TextWidget(
                                    title: AppConfig.addOffer.tr,
                                    fontSize: size.height * .018,
                                    color: colorScheme.onSecondary,
                                    isTextStart: true,
                                  ),
                            SizedBox(height: size.height * .03),
                            isAddProject
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        title: "\$",
                                        fontSize: size.width * .07,
                                        color: colorScheme.primary,
                                        isTextStart: false,
                                      ),
                                      SizedBox(width: size.width * .03),
                                      buildTextFormFaild(
                                        controller.priceController,
                                        AppConfig.price.tr,
                                        false,
                                        TextInputType.number,
                                        const Icon(Icons.add),
                                        colorScheme,
                                        size.width * .7,
                                        size.height * .1,
                                      ),
                                      Spacer(),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                              title: AppConfig.days.tr,
                                              fontSize: size.width * .05,
                                              color: colorScheme.primary,
                                              isTextStart: true,
                                            ),
                                            SizedBox(width: size.width * .03),
                                            buildTextFormFaild(
                                              controller.daysController,
                                              AppConfig.days.tr,
                                              false,
                                              TextInputType.number,
                                              const Icon(Icons.add),
                                              colorScheme,
                                              size.width * .7,
                                              size.height * .1,
                                            ),
                                          ]),
                                    ],
                                  ),
                            isAddProject
                                ? SizedBox()
                                : SizedBox(height: size.height * .02),
                            isAddProject
                                ? SizedBox()
                                : buildTextFormFaildDescription(
                                    controller.descriptionController,
                                    AppConfig.descreiption,
                                    false,
                                    TextInputType.text,
                                    const Icon(Icons.add),
                                    colorScheme,
                                  ),
                            SizedBox(height: size.height * .02),
                            isAddProject
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 25,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await addOffer(context);
                                      },
                                      child: isLoading
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 15),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.white)),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 15),
                                              child: TextWidget(
                                                  title: AppConfig.addOffer.tr,
                                                  fontSize: 20,
                                                  color: colorScheme.surface),
                                            ),
                                    ),
                                  ),
                            isAddProject
                                ? SizedBox()
                                : SizedBox(height: size.height * .02),
                            isAddProject
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: const Divider(),
                                  ),
                          ],
                        );
                    },
                  );
                }),

                Obx(() {
                  if (controller.loadingState.value == LoadingState.initial ||
                      controller.loadingState.value == LoadingState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (controller.loadingState.value ==
                          LoadingState.error ||
                      controller.loadingState.value ==
                          LoadingState.noDataFound) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReyTryErrorWidget(
                            title: controller.loadingState.value ==
                                    LoadingState.noDataFound
                                ? AppConfig.noData.tr
                                : controller.apiResponse.message,
                            onTap: () {
                              controller
                                  .getProjectsOffers(controller.results['id']);
                            })
                      ],
                    );
                  } else {
                    if (controller.resulte.length == 0) {
                      return NoData(
                        color: Colors.white,
                        height: size.height * .4,
                        textMessage: AppConfig.noOfferYet.tr,
                      );
                    }

                    return Column(
                      children: [
                        controller.resulte.length < 9
                            ? SizedBox()
                            : RowWithTwoText(
                                title: AppConfig.allOffer.tr,
                                description: AppConfig.seeAll.tr,
                                colorScheme: colorScheme.onSecondary,
                                colorScheme2: colorScheme.primary,
                                onTap: () {},
                              ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: size.height * .02),
                            itemCount: controller.resulte.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileEngineerScreen(
                                              engeneerId:
                                                  controller.resulte[index]
                                                      ['client']['id'])));
                                },
                                child: ListOffersEngineerWidget(
                                  offerController: controller,
                                  colorScheme: colorScheme,
                                  size: size,
                                  resulte: controller.resulte[index],
                                  index: index,
                                ),
                              );
                            }),
                      ],
                    );
                  }
                })
                // ListOffersEngineerWidget(),
              ],
            ),
          ),
        ));
  }

  Future<void> addOffer(BuildContext context) async {
    if (controller.daysController.text.isEmpty ||
        controller.descriptionController.text.isEmpty ||
        controller.priceController.text.isEmpty) {
      Helper.showError(
          context: context, subtitle: AppConfig.allFaildRequired.tr);
    } else if (int.parse(controller.priceController.text) < priceRange) {
      Helper.showError(
          context: context, subtitle: "${AppConfig.amountLess.tr} $priceRange");
    } else {
      setState(() => isLoading = true);

      isAddProject =
          await controller.addOffer(context, controller.results['id']);
      setState(() => isLoading = false);

      if (isAddProject) {
        controller.clearController();
        // Helper.showseuess(
        //     context: context, subtitle: AppConfig.addOfferSuccesfuly.tr);
        controller.getProjectsOffers(controller.results['id']);
      }
      // } else {
      //   Helper.showError(
      //       context: context, subtitle: AppConfig.cannotaddOffer.tr);
      // }
    }
  }

  buildRowList(context, String title, ColorScheme colorScheme, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 25,
          color: colorScheme.secondary,
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextWidget(
            title: title,
            fontSize: 18,
            color: colorScheme.onSecondary,
            isTextStart: true,
          ),
        ),
      ],
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.offerScreen.tr, fontSize: 18, color: Colors.white),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.navigate_before, size: 40),
        color: Colors.white,
      ),
    );
  }

  buildTextFormFaild(
    TextEditingController controller,
    String label,
    bool obscure,
    TextInputType inputType,
    Icon icon,
    ColorScheme colorScheme,
    double width,
    double height,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      height: height,
      child: Theme(
        data: ThemeData(
          colorScheme: ColorScheme(
            primary: colorScheme.primary,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.white,
            brightness: Brightness.light,
            background: Colors.black,
            onBackground: Colors.black,
            error: Colors.black,
            onError: Colors.black,
            surface: Colors.black,
            onSurface: Colors.black,
          ),
        ),
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          scribbleEnabled: true,
          decoration: InputDecoration(hintText: label),
          maxLength: null,
        ),
      ),
    );
  }

  buildTextFormFaildDescription(
    TextEditingController controller,
    String label,
    bool obscure,
    TextInputType inputType,
    Icon icon,
    ColorScheme colorScheme,
  ) {
    return SizedBox(
      child: Theme(
        data: ThemeData(
          colorScheme: ColorScheme(
            primary: colorScheme.primary,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.white,
            brightness: Brightness.light,
            background: Colors.black,
            onBackground: Colors.black,
            error: Colors.black,
            onError: Colors.black,
            surface: Colors.black,
            onSurface: Colors.black,
          ),
        ),
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          scribbleEnabled: true,
          decoration: InputDecoration(hintText: label),
          maxLength: 300,
          maxLines: 3,
        ),
      ),
    );
  }

  buildRowText(String title, String body, Size size, ColorScheme colorScheme) {
    return Row(
      children: [
        TextWidget(
          title: title + " : ",
          fontSize: size.height * .02,
          color: colorScheme.onSecondary,
          isTextStart: true,
        ),
        SizedBox(
          width: size.width * .04,
        ),
        TextWidget(
          title: body.toString(),
          fontSize: size.height * .017,
          color: colorScheme.primary,
          isTextStart: true,
        ),
      ],
    );
  }
}

// buildTextFormFaild(
//   TextEditingController controller,
//   String label,
//   bool obscure,
//   TextInputType inputType,
//   Icon icon,
//   ColorScheme colorScheme,
//   double width,
//   double height,
// ) {
//   return SizedBox(
//     width: width,
//     height: height,
//     child: Theme(
//       data: ThemeData(
//         colorScheme: ColorScheme(
//           primary: colorScheme.primary,
//           onPrimary: Colors.black,
//           secondary: Colors.black,
//           onSecondary: Colors.white,
//           brightness: Brightness.light,
//           background: Colors.black,
//           onBackground: Colors.black,
//           error: Colors.black,
//           onError: Colors.black,
//           surface: Colors.black,
//           onSurface: Colors.black,
//         ),
//       ),
//       child: TextField(
//         keyboardType: inputType,
//         scribbleEnabled: true,

//         decoration: InputDecoration(hintText: label),
//         // maxLength: 300,
//       ),
//     ),
//   );
// }
