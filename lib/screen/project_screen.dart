import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';
import '../app_config/app_config.dart';
import '../controller/project_screen_controller.dart';
import '../enum/all_enum.dart';
import '../widget/list_my_project_widget.dart';
import '../widget/shared_widgets/reytry_error_widget.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key, this.isMyProject = false}) : super(key: key);
  final bool isMyProject;

  @override
  Widget build(BuildContext context) {
    ProjectScreenController controller = Get.put(ProjectScreenController());
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () => controller.getOwnerProject(),
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              controller.goToAddProjectScreen();
            },
            // Navigator.of(context).pushNamed(AppConfig.addProjectScreen)),
            child: Row(
              children: [
                Icon(Icons.content_paste_go, color: Colors.white),
                SizedBox(width: size.width * .03),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextWidget(
                      title: AppConfig.addProjectScreen.tr,
                      fontSize: size.height * .025,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Obx(() {
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
                    title: controller.loadingState.value ==
                            LoadingState.noDataFound
                        ? AppConfig.noProjectsFound.tr
                        : controller.apiResponse.message,
                    onTap: () {
                      controller.getOwnerProject();
                    })
              ],
            );
          } else {
            // ListProjectWidget
            return ListView.builder(
              // shrinkWrap: true,
              itemCount: controller.myProjects.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ListMyProjectWidget(
                    ownerProjectModel: controller.myProjects[index],
                    colorScheme: colorScheme,
                    isMyProject: isMyProject,
                    size: size,
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }

  void navigatorToNewScreen(BuildContext context, screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.addProjectScreen.tr,
            fontSize: 18,
            color: Colors.white),
      ),
    );
  }
}
