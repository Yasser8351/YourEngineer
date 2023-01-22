import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/controller/project_home_controller.dart';
import 'package:your_engineer/controller/top_engineer_controller.dart';
import 'package:your_engineer/screen/engineers/all_engineer_screen.dart';
import 'package:your_engineer/screen/project_screen.dart';
import 'package:your_engineer/screen/services/all_populer_services_screen.dart';
import 'package:your_engineer/widget/list_project_widget.dart';
import 'package:your_engineer/widget/shared_widgets/reytry_error_widget.dart';
import 'package:your_engineer/widget/shared_widgets/shimmer_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_with_icon_widget.dart';

import '../app_config/app_config.dart';
import '../controller/populer_services_controller.dart';
import '../enum/all_enum.dart';
import '../widget/lis_top_engineer_rating_widget.dart';
import '../widget/list_populer_services_widget.dart';
import '../widget/shared_widgets/row_two_with_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProjectControllerHome projectController = Get.put(ProjectControllerHome());
  PopulerServicesController populerServicesController =
      Get.put(PopulerServicesController());
  TopEngineerController topEngineerController =
      Get.put(TopEngineerController());

  // PopulerServicesController populerServicesController = Get.find();
  // TopEngineerController topEngineerController = Get.find();
  // ProjectControllerHome projectController = Get.find();

  //////
  double rating = 3.5;

  initController() {
    projectController.getProjects();
    populerServicesController.getCategorys();
    topEngineerController.getTopEngineer();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    log("message");
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return initController();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: size.height * .07),

                // Headar of Screen
                // that contains Text App name and icons of notifcation
                TextWithIconWidget(
                    onTapNotifications: () =>
                        Navigator.of(context).pushNamed(AppConfig.notifcation)),

                // Space
                const SizedBox(height: 20),

                // SearchWidget
                // SearchWidget(onTap: () {}),

                // Space
                const SizedBox(height: 35),

                //////////==========================================================

                // Text Populer Services and See All
                RowWithTwoText(
                  title: AppConfig.lastProject.tr,
                  description: AppConfig.seeAll.tr,
                  colorScheme: colorScheme.onSecondary,
                  colorScheme2: colorScheme.primary,
                  onTap: (() =>
                      navigatorToNewScreen(context, const ProjectScreen())),
                ),

                // // ListProjectWidget

                Obx(() {
                  if (projectController.loadingState.value ==
                          LoadingState.initial ||
                      projectController.loadingState.value ==
                          LoadingState.loading) {
                    return ShimmerWidget(size: size);
                  } else if (projectController.loadingState.value ==
                          LoadingState.error ||
                      projectController.loadingState.value ==
                          LoadingState.noDataFound) {
                    return ReyTryErrorWidget(
                        title: projectController.loadingState.value ==
                                LoadingState.noDataFound
                            ? AppConfig.noProjectsFound.tr
                            : projectController.apiResponse.message,
                        onTap: () {
                          projectController.getProjects();
                        });
                  } else {
                    return SizedBox(
                      height: size.height * .25,
                      width: double.infinity,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 18),
                        scrollDirection: Axis.horizontal,
                        itemCount: projectController.results.length,
                        itemBuilder: (context, index) {
                          return ListProjectWidget(
                            index: index,
                            results: projectController.results[index],
                            colorScheme: colorScheme,
                            size: size,
                          );
                          //[index]
                        },
                      ),
                    );
                  }
                }),
                // Space between list in Home Screen

                const SizedBox(height: 40),

                // Text Populer Services and See All
                RowWithTwoText(
                  title: AppConfig.populerServices.tr,
                  description: AppConfig.seeAll.tr,
                  colorScheme: colorScheme.onSecondary,
                  colorScheme2: colorScheme.primary,
                  onTap: (() => navigatorToNewScreen(
                        context,
                        AllPopulerServicesScreen(
                            listPopulerServices:
                                populerServicesController.listPopulerServices,
                            colorScheme: colorScheme,
                            size: size),
                      )),
                ),

                // ListPopulerServicesWidget
                Obx(
                  () {
                    if (populerServicesController.loadingState.value ==
                            LoadingState.initial ||
                        populerServicesController.loadingState.value ==
                            LoadingState.loading) {
                      return ShimmerWidget(size: size);
                    } else if (populerServicesController.loadingState.value ==
                            LoadingState.error ||
                        populerServicesController.loadingState.value ==
                            LoadingState.noDataFound) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReyTryErrorWidget(
                              title: populerServicesController
                                          .loadingState.value ==
                                      LoadingState.noDataFound
                                  ? AppConfig.noData.tr
                                  : populerServicesController.message,
                              onTap: () {
                                populerServicesController.getCategorys();
                              })
                        ],
                      );
                    } else if (populerServicesController.loadingState ==
                        LoadingState.token) {
                      return Text("");

                      // populerServicesController.logout(context);
                    } else {
                      return SizedBox(
                        height: size.height * .3,
                        width: double.infinity,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 18),
                          scrollDirection: Axis.horizontal,
                          itemCount: populerServicesController
                              .listPopulerServices.length,
                          itemBuilder: (context, index) {
                            return ListPopulerServicesWidget(
                              populerServicesModel: populerServicesController
                                  .listPopulerServices[index],
                              colorScheme: colorScheme,
                              size: size,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),

                // Space between list in Home Screen
                const SizedBox(height: 40),

                // Text Top Engineer Rating and See All
                RowWithTwoText(
                  title: AppConfig.topEngineerRating.tr,
                  description: AppConfig.seeAll.tr,
                  colorScheme: colorScheme.onSecondary,
                  colorScheme2: colorScheme.primary,
                  onTap: (() => navigatorToNewScreen(
                        context,
                        AllEngineersScreen(
                            // topEngineerController: topEngineerController,
                            listEngineers:
                                topEngineerController.listTopEngineer,
                            // topEngineerController.listTopEngineer,
                            colorScheme: colorScheme,
                            size: size),
                      )),
                ),

                // ListTopEngineerRatingWidget
                Obx(
                  () {
                    if (topEngineerController.loadingState.value ==
                            LoadingState.initial ||
                        topEngineerController.loadingState.value ==
                            LoadingState.loading) {
                      return ShimmerWidget(size: size);
                    } else if (topEngineerController.loadingState.value ==
                        LoadingState.error) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReyTryErrorWidget(
                                title: topEngineerController.message,
                                onTap: () {
                                  topEngineerController.getTopEngineer();
                                })
                          ]);
                    } else {
                      return SizedBox(
                        height: size.height * .36,
                        width: double.infinity,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 18),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              topEngineerController.listTopEngineer.length,
                          itemBuilder: (context, index) {
                            return ListTopEngineerRatingWidget(
                              topEngineerRatingModel:
                                  topEngineerController.listTopEngineer[index],
                              colorScheme: colorScheme,
                              size: size,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),

                // Space between list and Bottom Page
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigatorToNewScreen(BuildContext context, screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
