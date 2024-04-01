import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/controller/fag_controller.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/widget/shared_widgets/build_row_list.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';

import '../model/owner_project_model.dart';
import '../screen/project/my_project_offers_screen.dart';
import 'shared_widgets/card_decoration.dart';

class ListMyProjectWidget extends StatelessWidget {
  const ListMyProjectWidget(
      {Key? key,
      required this.ownerProjectModel,
      required this.colorScheme,
      required this.size,
      required this.isMyProject})
      : super(key: key);
  final OwnerProjectModel ownerProjectModel;
  final ColorScheme colorScheme;
  final Size size;
  final bool isMyProject;

  @override
  Widget build(BuildContext context) {
    FaqController controller = Get.find();

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {
          Get.to(
              () => MyProjectOffersScreen(
                    size: size,
                    colorScheme: colorScheme,
                    projectid: ownerProjectModel.id,
                    ownerProjectModel: ownerProjectModel,
                  ),
              arguments: {'projectId': ownerProjectModel.id});
        },
        height: isMyProject &&
                ownerProjectModel.projStatus!.statName!.contains("In-Progress")
            ? size.height * .42
            : size.height * .36,
        width: size.width * .7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConfig.projectName.tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size.height * .017,
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
                  fontSize: size.height * .02,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppConfig.projectDescription.tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size.height * .017,
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ownerProjectModel.projDescription,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size.height * .02,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
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
                        title: getTitleStatusProject(
                            ownerProjectModel.projStatus!.statName!),
                        // title: ownerProjectModel.projStatus!.statName,
                        colorScheme: colorScheme,
                        icon: getIconStatusProject(
                            ownerProjectModel.projStatus!.statName!),
                        description: AppConfig.projectState.tr,
                      ),
                      BuildRowList(
                        title: isMyProject
                            ? ownerProjectModel.offersCount == 0
                                ? "0"
                                : ownerProjectModel.offersCount.toString()
                            : ownerProjectModel.offersCount.toString(),
                        colorScheme: colorScheme,
                        icon: Icons.post_add,
                        description: AppConfig.offerCount.tr,
                      ),
                      BuildRowList(
                        title: ownerProjectModel.priceRange!.rangeName,
                        colorScheme: colorScheme,
                        icon: CupertinoIcons.money_dollar,
                        description: AppConfig.projectBudget.tr,
                      ),
                      BuildRowList(
                        title: GetTimeAgo.parse(
                            DateTime.parse(ownerProjectModel.createdAt),
                            pattern: "dd-MM-yyyy hh:mm aa",
                            locale: 'ar'),
                        colorScheme: colorScheme,
                        icon: Icons.watch_later,
                        description: AppConfig.dateOfPublication.tr,
                      ),
                    ],
                  ),
                  isMyProject
                      ? CardWithImage(
                          height: size.height * .05,
                          width: size.width * .1,
                          colors: const Color.fromARGB(255, 184, 184, 184),
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => AddProjectScreen(
                            //       projectModel: projectModel,
                            //       isMyProject: true,
                            //     ),
                            //   ),
                            // );
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ))
                      : const SizedBox(),
                ],
              ),
              isMyProject &&
                      ownerProjectModel.projStatus!.statName!
                          .contains("In-Progress")
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Obx(
                        () => controller.loadingStateCompleteProject ==
                                LoadingState.loading
                            ? Center(child: CircularProgressIndicator())
                            : Center(
                                child: ElevatedButton(
                                  onPressed: () => controller.completeProject(
                                      context, ownerProjectModel.id),
                                  child: Text(
                                    AppConfig.receivingProject.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

IconData getIconStatusProject(String statName) {
  if (statName.contains("Open")) {
    return Icons.open_in_browser;
  } else if (statName.contains("In-Progress")) {
    return Icons.blinds;
  } else if (statName.contains("Completed")) {
    return Icons.check_box;
  } else {
    return Icons.close;
  }
}

String getTitleStatusProject(String statName) {
  if (statName.contains("Open")) {
    return AppConfig.open.tr;
  } else if (statName.contains("In-Progress")) {
    return AppConfig.inProgress.tr;
  } else if (statName.contains("Completed")) {
    return AppConfig.completed.tr;
  } else {
    return AppConfig.close.tr;
  }
}
