import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/widget/shared_widgets/build_row_list.dart';

import '../../app_config/app_config.dart';
import '../../controller/accept_offer_controller.dart';
import '../../controller/my_project_offers_screen_controller.dart';
import '../../enum/all_enum.dart';
import '../../model/owner_project_model.dart';
import '../../utilits/helper.dart';
import '../../widget/list_my_project_offers_widget.dart';
import '../../widget/shared_widgets/card_decoration.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';

class MyProjectOffersScreen extends StatelessWidget {
  const MyProjectOffersScreen(
      {Key? key,
      required this.projectid,
      required this.size,
      required this.ownerProjectModel,
      required this.colorScheme})
      : super(key: key);
  final String projectid;
  final Size size;
  final ColorScheme colorScheme;
  final OwnerProjectModel ownerProjectModel;

  @override
  Widget build(BuildContext context) {
    MyProjectOffersScreenController controller =
        Get.put(MyProjectOffersScreenController());

    AcceptOfferController acceptofferController =
        Get.put(AcceptOfferController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)),
        ],
      ),
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
              ReyTryErrorWidget(
                  title:
                      controller.loadingState.value == LoadingState.noDataFound
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
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: CardDecoration(
                      onTap: () {},
                      height: size.height * .36,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اسم المشروع",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: colorScheme.onSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              ownerProjectModel.projTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "وصف المشروع",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: colorScheme.onSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: size.height * .06,
                              child: Text(
                                ownerProjectModel.projDescription,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BuildRowList(
                                      title: ownerProjectModel
                                          .projStatus!.statName,
                                      colorScheme: colorScheme,
                                      icon: ownerProjectModel
                                              .projStatus!.statName!
                                              .contains("Open")
                                          ? Icons.open_in_browser
                                          : ownerProjectModel
                                                  .projStatus!.statName!
                                                  .contains("In-Progress")
                                              ? Icons.blinds
                                              : ownerProjectModel
                                                      .projStatus!.statName!
                                                      .contains("Close")
                                                  ? Icons.close
                                                  : Icons.local_dining,
                                      description: "حالة المشروع",
                                    ),
                                    BuildRowList(
                                      title: dateFormat(
                                          ownerProjectModel.createdAt),
                                      colorScheme: colorScheme,
                                      icon: Icons.watch_later,
                                      description: "تاريخ الانشاء",
                                    ),
                                    BuildRowList(
                                      title: ownerProjectModel.offersCount
                                          .toString(),
                                      colorScheme: colorScheme,
                                      icon: Icons.post_add,
                                      description: "عدد العروض",
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (controller.resulte.isEmpty)
                    Column(
                      children: [
                        SizedBox(height: size.height / 5.5),
                        TextWidget(
                            title: "لاتوجد عروض بعد",
                            fontSize: 20,
                            color: Colors.black),
                      ],
                    ),
                  SizedBox(height: size.height * .05),
                  if (controller.resulte.isNotEmpty)
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextWidget(
                          isTextStart: true,
                          title: "كل العروض ",
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  SizedBox(height: size.height * .02),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: size.height * .02),
                    itemCount: controller.resulte.length,
                    itemBuilder: (context, index) => ListMyProjectOffersWidget(
                      colorScheme: colorScheme,
                      controller: acceptofferController,
                      projectStatus: getProjectStatus(
                          ownerProjectModel.projStatus!.statName!),
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
      }),
    );
  }
}
