import 'package:flutter/material.dart';

import '../app_config/app_config.dart';
import '../app_config/app_image.dart';
import '../model/project_model.dart';
import '../widget/list_my_project_widget.dart';
import '../widget/shared_widgets/no_data.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProjectModel> listProject = [
      ProjectModel(
        titleProject: '3D design for interior design',
        descriptionProject:
            'Project details Project detailsProject details Project details Project details Project detailsProject details',
        postBy: "Open",
        createdDate: "2 days ago",
        numberOfoffers: "add first offers",
      ),
      ProjectModel(
        titleProject: 'Making tables of quantities',
        descriptionProject:
            'Quantity surveying is required for all systems for a small villa in Saudi Arabia with high accuracy',
        postBy: "In progress",
        createdDate: "1 hours ago",
        numberOfoffers: "13 offers",
      ),
      ProjectModel(
        titleProject: 'health club design',
        descriptionProject:
            'Interior design of a health club (SPA) of about 8 m by 8 m already built, including a salt cave, Moroccan bath, massage, jacuzzi, sauna, toilet and dressing room',
        postBy: "Completed",
        createdDate: "15 hours ago",
        numberOfoffers: "5 offers",
      ),
      ProjectModel(
        titleProject: '3D design for interior design',
        descriptionProject:
            'Project details Project detailsProject details Project details Project details Project detailsProject details',
        postBy: "Open",
        createdDate: "2 days ago",
        numberOfoffers: "8 offers",
      ),
    ];

    int data = 1;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
            shrinkWrap: true,
            itemCount: listProject.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: ListMyProjectWidget(
                  projectModel: listProject[index],
                  colorScheme: colorScheme,
                  size: size,
                ),
              );
            },
          );
        }
      }),
    );
  }
}
