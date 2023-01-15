import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:your_engineer/screen/project/add_project_screen.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../app_config/app_config.dart';
import '../app_config/app_image.dart';
import '../model/project_model.dart';
import '../widget/list_my_project_widget.dart';
import '../widget/list_project_widget.dart';
import '../widget/shared_widgets/no_data.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key, this.isMyProject = false}) : super(key: key);
  final bool isMyProject;

  @override
  Widget build(BuildContext context) {
    List<ProjectModel> listProject = [
      // ProjectModel(
      //   titleProject: '3D design for interior design',
      //   categoryProject: '',
      //   descriptionProject:
      //       'Project details Project detailsProject details Project details Project details Project detailsProject details',
      //   postBy: "Open",
      //   createdDate: "2 days ago",
      //   numberOfoffers: "add first offers",
      // ),
      // ProjectModel(
      //   titleProject: 'Making tables of quantities',
      //   categoryProject: '',
      //   descriptionProject:
      //       'Quantity surveying is required for all systems for a small villa in Saudi Arabia with high accuracy',
      //   postBy: "In progress",
      //   createdDate: "1 hours ago",
      //   numberOfoffers: "13 offers",
      // ),
      // ProjectModel(
      //   titleProject: 'health club design',
      //   categoryProject: '',
      //   descriptionProject:
      //       'Interior design of a health club (SPA) of about 8 m by 8 m already built, including a salt cave, Moroccan bath, massage, jacuzzi, sauna, toilet and dressing room',
      //   postBy: "Completed",
      //   createdDate: "15 hours ago",
      //   numberOfoffers: "5 offers",
      // ),
      // ProjectModel(
      //   titleProject: '3D design for interior design',
      //   categoryProject: '',
      //   descriptionProject:
      //       'Project details Project detailsProject details Project details Project details Project detailsProject details',
      //   postBy: "Open",
      //   createdDate: "2 days ago",
      //   numberOfoffers: "8 offers",
      // ),
    ];

    int data = 1;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.navigate_before, size: 40),
          color: Colors.white,
        ),
        title: InkWell(
          onTap: (() => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddProjectScreen(
                  projectModel: ProjectModel(
                      totalItems: 0,
                      results: [],
                      totalPages: 0,
                      currentPage: 0))))),
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
      body: Builder(builder: (context) {
        if (data == 0) {
          return NoData(
            isPostScreen: true,
            textMessage: AppConfig.noProjectYet,
            imageUrlAssets: AppImage.noProject,
            onTap: (() {
              //go To AddPostScreen
              Navigator.of(context).pushNamed(AppConfig.addProjectScreen);
            }),
          );
        } else {
          // ListProjectWidget
          return ListView.builder(
            // shrinkWrap: true,
            itemCount: listProject.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: ListMyProjectWidget(
                  projectModel: listProject[index],
                  colorScheme: colorScheme,
                  isMyProject: isMyProject,
                  size: size,
                ),
              );
            },
          );
        }
      }),
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
      // leading: IconButton(
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      //   icon: const Icon(Icons.navigate_before, size: 40),
      //   color: Colors.white,
      // ),
    );
  }
}
