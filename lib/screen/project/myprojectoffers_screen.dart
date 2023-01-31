import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_config/app_config.dart';
import '../../controller/myprojectoffers_screen_controller.dart';
import '../../enum/all_enum.dart';
import '../../widget/list_myprojectoffers_widget.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';

class MyProjectOffersScreen extends StatelessWidget {
  const MyProjectOffersScreen(
      {Key? key,
      required this.projectid,
      required this.size,
      required this.colorScheme})
      : super(key: key);
  final String projectid;
  final Size size;
  final ColorScheme colorScheme;
  @override
  Widget build(BuildContext context) {
    MyProjectOffersScreenController controller =
        Get.put(MyProjectOffersScreenController());

    return Scaffold(
        //
        body: //
            Obx(() {
      if (controller.loadingState.value == LoadingState.initial ||
          controller.loadingState.value == LoadingState.loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.loadingState.value == LoadingState.error ||
          controller.loadingState.value == LoadingState.noDataFound) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("${controller.message}"),
            Text("nnnnnn"),
            ReyTryErrorWidget(
                title: controller.loadingState.value == LoadingState.noDataFound
                    ? AppConfig.noData.tr
                    : controller.apiResponse.message,
                onTap: () {
                  controller.getProjectsOffers(projectid);
                })
          ],
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * .02),
                TextWidget(
                    title: "مشــاريـــعي", fontSize: 20, color: Colors.black),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: size.height * .02),
                  itemCount: controller.resulte.length,
                  itemBuilder: (context, index) => ListMyProjectOffersWidget(
                    colorScheme: colorScheme,
                    size: size,
                    isMyProject: true,
                    resulte: controller.resulte[index],
                  ),
                )
              ],
            ),
          ),
        );
      }
    }));
  }
}
