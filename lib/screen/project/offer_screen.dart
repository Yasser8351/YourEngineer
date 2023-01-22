import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/widget/shared_widgets/no_data.dart';
import 'package:your_engineer/widget/shared_widgets/row_two_with_text.dart';

import '../../app_config/app_config.dart';
import '../../controller/offers_controller.dart';
import '../../debugger/my_debuger.dart';
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
    // required this.result,
    //  required this.projectModel, this.isMyProject = false
  }) : super(key: key);
  // final List<dynamic> result;
  // final int index;

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  OfferController controller = Get.put(OfferController());
  bool isLoading = false;

  // initalControllers() {
  //   titleController.text = widget.projectModel.projTitle;
  //   descriptionController.text = widget.projectModel.projDescription;
  //   daysController.text = widget.projectModel.projTitle;
  // }

  // @override
  // RangeValues selectedRange = const RangeValues(25, 50);
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // int userOfferCount = controller.userOfferCount;
    // int isProjectOwner = controller.isProjectOwner;
    // log(userOfferCount.toString());
    // log(isProjectOwner.toString());

    Size size = MediaQuery.of(context).size;
    // dynamic result = Get.arguments['results'];

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
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * .03),
                        TextWidget(
                            title: "${AppConfig.projectTitle.tr} :",
                            fontSize: size.height * .025,
                            color: colorScheme.background),
                        TextWidget(
                            title: controller.results['proj_title'],
                            fontSize: size.height * .025,
                            color: colorScheme.primary),
                        SizedBox(height: size.height * .02),
                        TextWidget(
                            title: "${AppConfig.projectDetails.tr} :",
                            fontSize: size.height * .025,
                            color: colorScheme.background),
                        SizedBox(height: size.height * .02),
                        TextWidget(
                          title: controller.results['proj_description'],
                          fontSize: size.height * .025,
                          color: colorScheme.primary,
                          isTextStart: true,
                        ),
                        SizedBox(height: size.height * .031),
                      ],
                    ),
                  ),
                )),

                SizedBox(height: size.height * .07),
                const Divider(),

                Builder(builder: (context) {
                  return Obx(
                    () {
                      if (controller.loadingProject.value ==
                              LoadingState.initial ||
                          controller.loadingProject.value ==
                              LoadingState.loading)
                        return Center(child: CircularProgressIndicator());
                      else if (controller.userOfferCount > 0 ||
                          controller.isProjectOwner == 1) {
                        return SizedBox();
                      } else
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: AppConfig.addOffer.tr,
                              fontSize: size.height * .025,
                              color: colorScheme.onSecondary,
                              isTextStart: true,
                            ),
                            SizedBox(height: size.height * .03),
                            Row(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                            SizedBox(height: size.height * .02),
                            buildTextFormFaildDescription(
                              controller.descriptionController,
                              AppConfig.descreiption,
                              false,
                              TextInputType.text,
                              const Icon(Icons.add),
                              colorScheme,
                            ),
                            SizedBox(height: size.height * .02),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 25,
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (controller.daysController.text.isEmpty ||
                                      controller
                                          .descriptionController.text.isEmpty ||
                                      controller.priceController.text.isEmpty) {
                                    Helper.showError(
                                        context: context,
                                        subtitle:
                                            AppConfig.allFaildRequired.tr);
                                  } else {
                                    setState(() => isLoading = true);

                                    bool isAddProject =
                                        await controller.addOffer(
                                            context, controller.results['id']);
                                    myLog('isAddProject', isAddProject);
                                    setState(() => isLoading = false);

                                    if (isAddProject) {
                                      controller.clearController();
                                      Helper.showseuess(
                                          context: context,
                                          subtitle:
                                              AppConfig.addOfferSuccesfuly.tr);
                                      controller.getProjectsOffers(
                                          controller.results['id']);
                                    } else {
                                      Helper.showError(
                                          context: context,
                                          subtitle:
                                              AppConfig.cannotaddOffer.tr);
                                    }
                                  }
                                },
                                child: isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        child: Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.white)),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 15),
                                        child: TextWidget(
                                            title: AppConfig.addOffer,
                                            fontSize: 20,
                                            color: colorScheme.surface),
                                      ),
                              ),
                            ),
                            SizedBox(height: size.height * .02),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: const Divider(),
                            ),
                          ],
                        );
                    },
                  );
                }),

                RowWithTwoText(
                  title: AppConfig.allOffer.tr,
                  description: AppConfig.seeAll.tr,
                  colorScheme: colorScheme.onSecondary,
                  colorScheme2: colorScheme.primary,
                  onTap: () {},
                ),
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
                        textMessage: "لاتوجد عروض بعد",
                      );
                    }
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: size.height * .02),
                      itemCount: controller.resulte.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProfileEngineerScreen(engeneerId: '')));
                        },
                        child: ListOffersEngineerWidget(
                          colorScheme: colorScheme,
                          size: size,
                          resulte: controller.resulte[index],
                        ),
                      ),
                    );
                  }
                })
                // ListOffersEngineerWidget(),
              ],
            ),
          ),
        ));
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
