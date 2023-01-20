import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/widget/shared_widgets/no_data.dart';
import 'package:your_engineer/widget/shared_widgets/shimmer_widget.dart';

import '../../app_config/app_config.dart';
import '../../controller/sub_service_screen_controller.dart';
import '../../enum/all_enum.dart';
import '../../model/project_model.dart';
import '../../widget/list_project_widget.dart';
import '../../widget/list_sub_services_widget.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';

class SubServicesScreen extends StatefulWidget {
  const SubServicesScreen({
    Key? key,
  }) : super(key: key);
  // final String titleServices;
  // final List<SubServicesModel> listSubServices;

  @override
  State<SubServicesScreen> createState() => _SubServicesScreenState();
}

class _SubServicesScreenState extends State<SubServicesScreen> {
  SubServiceScreenController controller = Get.put(SubServiceScreenController());
  String search = '';
  List<ProjectModel> listProject = [];
  int expandeIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context, controller.title.toString()),
      body: Obx(() {
        if (controller.loadingState.value == LoadingState.initial ||
            controller.loadingState.value == LoadingState.loading) {
          return Center(
            child: ShimmerWidget(size: size),
          );
        } else if (controller.loadingState.value == LoadingState.error) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReyTryErrorWidget(
                  title: controller.apiResponse.message,
                  onTap: () {
                    controller.getSubCatigory(controller.id.toString());
                  })
            ],
          );
        } else if (controller.listSubServices.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReyTryErrorWidget(
                  title: AppConfig.noData.tr,
                  onTap: () {
                    controller.getSubCatigory(controller.id.toString());
                  })
            ],
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * .015),

                // List Sub Services horizantial this list using to
                // filter main List by title Sub Services
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.listSubServices.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          setState(() {
                            expandeIndex = index;
                            controller
                                .getProjectBySubCatigory(controller
                                    .listSubServices[index].id
                                    .toString())
                                .then((value) => setState(() {}));
                          });
                        },
                        child: ListSubServicesWidget(
                          subServicesModel: controller.listSubServices[index],
                          colorScheme: colorScheme,
                          size: size,
                          index: index,
                          expandeIndex: expandeIndex,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: size.height * .01),

                // List Project Services contains category
                // using cateogry to filter this list
                GetBuilder<SubServiceScreenController>(
                  builder: (controller) => controller.isLoadingProject == true
                      ? ShimmerWidget(size: size)
                      : controller.results.isEmpty
                          ? NoData(
                              textMessage:
                                  "${AppConfig.noProjectsFound.tr} ${AppConfig.withKeySearch.tr}",
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.results.length,
                              itemBuilder: (context, index) =>
                                  ListProjectWidget(
                                results: controller.results[index],
                                colorScheme: colorScheme,
                                size: size,
                                index: index,
                              ),
                            ),
                )
              ],
            ),
          );
        }
      }),
    );
  }

  _getAppBar(BuildContext context, String titleServices) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child:
            TextWidget(title: titleServices, fontSize: 18, color: Colors.white),
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
}
