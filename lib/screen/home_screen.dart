import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/model/populer_services_model.dart';
import 'package:your_engineer/model/project_model.dart';
import 'package:your_engineer/widget/lis_top_engineer_rating_widget.dart';
import 'package:your_engineer/widget/list_project_widget.dart';
import 'package:your_engineer/widget/search_widget.dart';
import 'package:your_engineer/widget/text_with_icon_widget.dart';

import '../app_config/app_config.dart';
import '../model/top_engineer_rating_model.dart';
import '../widget/list_populer_services_widget.dart';
import '../widget/row_two_with_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TopEngineerRatingModel> listTopEngineerRating = [
    TopEngineerRatingModel(
      engineerName: "Yasser Abubaker",
      engineerspecialist: "Architecture Engineer",
      imageUrl: AppImage.img4,
      engineerRating: 4.5,
    ),
    TopEngineerRatingModel(
      engineerName: "Ahmed Ali",
      engineerspecialist: "Civil Engineer",
      imageUrl: AppImage.img11,
      engineerRating: 3.5,
    ),
    TopEngineerRatingModel(
      engineerName: "Omer Osman",
      engineerspecialist: "Civil Engineer",
      imageUrl: AppImage.img12,
      engineerRating: 1.5,
    ),
  ];
  List<PopulerServicesModel> listPopulerServices = [
    PopulerServicesModel(
        titleServices: "Architectural Design", imageUrlServices: AppImage.img9),
    PopulerServicesModel(
        titleServices: "Autocad Diagram", imageUrlServices: AppImage.img8),
    PopulerServicesModel(
        titleServices: "3D Design", imageUrlServices: AppImage.img7),
  ];
  List<ProjectModel> listProject = [
    ProjectModel(
      titleProject: 'Making tables of quantities',
      descriptionProject:
          'Quantity surveying is required for all systems for a small villa in Saudi Arabia with high accuracy',
    ),
    ProjectModel(
      titleProject: 'health club design',
      descriptionProject:
          'Interior design of a health club (SPA) of about 8 m by 8 m already built, including a salt cave, Moroccan bath, massage, jacuzzi, sauna, toilet and dressing room',
    ),
    ProjectModel(
        titleProject: '3D design for interior design',
        descriptionProject:
            'Project details Project detailsProject details Project details Project details Project detailsProject details')
  ];

  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: size.height * .07),

              // Headar of Screen
              // that contains text App name and icons of notifcation
              TextWithIconWidget(
                  onTapNotifications: () =>
                      Navigator.of(context).pushNamed(AppConfig.notifcation)),

              // Space
              const SizedBox(height: 20),

              // SearchWidget
              SearchWidget(onTap: () {}),

              // Space
              const SizedBox(height: 35),

              // Text Populer Services and See All
              RowWithTwoText(
                title: AppConfig.lastProject,
                description: AppConfig.seeAll,
                colorScheme: colorScheme.onSecondary,
                colorScheme2: colorScheme.primary,
              ),

              // ListProjectWidget
              SizedBox(
                height: size.height * .25,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: listProject.length,
                  itemBuilder: (context, index) {
                    return ListProjectWidget(
                      projectModel: listProject[index],
                      colorScheme: colorScheme,
                      size: size,
                    );
                  },
                ),
              ),

              // Space between list in Home Screen
              const SizedBox(height: 40),

              // Text Populer Services and See All
              RowWithTwoText(
                title: AppConfig.populerServices,
                description: AppConfig.seeAll,
                colorScheme: colorScheme.onSecondary,
                colorScheme2: colorScheme.primary,
              ),

              // ListPopulerServicesWidget
              SizedBox(
                height: size.height * .3,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: listPopulerServices.length,
                  itemBuilder: (context, index) {
                    return ListPopulerServicesWidget(
                      populerServicesModel: listPopulerServices[index],
                    );
                  },
                ),
              ),

              // Space between list in Home Screen
              const SizedBox(height: 40),

              // Text Top Engineer Rating and See All
              RowWithTwoText(
                title: AppConfig.topEngineerRating,
                description: AppConfig.seeAll,
                colorScheme: colorScheme.onSecondary,
                colorScheme2: colorScheme.primary,
              ),

              // ListTopEngineerRatingWidget
              SizedBox(
                height: size.height * .36,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: listTopEngineerRating.length,
                  itemBuilder: (context, index) {
                    return ListTopEngineerRatingWidget(
                      topEngineerRatingModel: listTopEngineerRating[index],
                    );
                  },
                ),
              ),

              // Space between list and Bottom Page
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}




/* 
  _getAppBar(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.home, fontSize: 18, color: Colors.white),
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
  */