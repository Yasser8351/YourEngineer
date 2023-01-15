import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/controller/project_controller.dart';
import 'package:your_engineer/controller/top_engineer_controller.dart';
import 'package:your_engineer/model/project_model.dart';
import 'package:your_engineer/screen/engineers/all_engineer_screen.dart';
import 'package:your_engineer/screen/project_screen.dart';
import 'package:your_engineer/screen/services/all_populer_services_screen.dart';
import 'package:your_engineer/widget/list_project_widget.dart';
import 'package:your_engineer/widget/shared_widgets/reytry_error_widget.dart';
import 'package:your_engineer/widget/shared_widgets/search_widget.dart';
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
  final PopulerServicesController populerServicesController = Get.find();
  final TopEngineerController topEngineerController = Get.find();
  final ProjectController projectController = Get.find();

  //////
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
              // that contains Text App name and icons of notifcation
              TextWithIconWidget(
                  onTapNotifications: () =>
                      Navigator.of(context).pushNamed(AppConfig.notifcation)),

              // Space
              const SizedBox(height: 20),

              // SearchWidget
              SearchWidget(onTap: () {}),

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
                          ? AppConfig.noData.tr
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
                          results: projectController.results,
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
                        Text("${populerServicesController.message}"),
                        ReyTryErrorWidget(
                            title: populerServicesController
                                        .loadingState.value ==
                                    LoadingState.noDataFound
                                ? AppConfig.noData.tr
                                : populerServicesController.apiResponse.message,
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
                          listEngineers: const [],
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
                          Text("${topEngineerController.message}"),
                          ReyTryErrorWidget(
                              title: topEngineerController.apiResponse.message,
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
                        itemCount: topEngineerController.listTopEngineer.length,
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
    );
  }

  void navigatorToNewScreen(BuildContext context, screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
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

  /*
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
      titleServices: "Sketches",
      imageUrlServices: AppImage.img8,
      listSubServices: [
        //Sketches
        SubServicesModel(id: 0, title: "All"),
        SubServicesModel(id: 1, title: "Electricity Distribution Scheme"),
        SubServicesModel(id: 2, title: "Pumbing Distribution Chart"),
        SubServicesModel(id: 3, title: "Furniture Distribution Chart"),
        SubServicesModel(id: 4, title: "Full Scheme"),
      ],
    ),
    PopulerServicesModel(
      titleServices: "Interface Design",
      imageUrlServices: AppImage.img9,
      listSubServices: [
        //Sketches
        SubServicesModel(id: 0, title: "All"),
        SubServicesModel(id: 1, title: "All Styles"),
      ],
    ),
    PopulerServicesModel(
      titleServices: "Interior Design",
      imageUrlServices: AppImage.img7,
      listSubServices: [
        //Sketches
        SubServicesModel(id: 0, title: "All"),
        SubServicesModel(id: 1, title: "2D or 3D"),
        SubServicesModel(id: 2, title: "Classic"),
        SubServicesModel(id: 3, title: "Necolassic"),
        SubServicesModel(id: 4, title: "Modern"),
        SubServicesModel(id: 5, title: "Bohemain"),
        SubServicesModel(id: 6, title: "Rural"),
      ],
    ),
    PopulerServicesModel(
      titleServices: "Type of Place",
      imageUrlServices: AppImage.img7,
      listSubServices: [
        //Sketches
        SubServicesModel(id: 0, title: "All"),
        SubServicesModel(id: 1, title: "Commercial"),
        SubServicesModel(id: 2, title: "Residential"),
      ],
    ),
    PopulerServicesModel(
      titleServices: "Customer Type",
      imageUrlServices: AppImage.img7,
      listSubServices: [
        //Sketches
        SubServicesModel(id: 0, title: "All"),
        SubServicesModel(id: 1, title: "Company"),
        SubServicesModel(id: 2, title: "Individuais"),
      ],
    ),
  ];
   */
  // List<ProjectModel> listProject = [
  // ProjectModel(
  //   titleProject: 'Making tables of quantities',
  //   categoryProject: '',
  //   descriptionProject:
  //       'Quantity surveying is required for all systems for a small villa in Saudi Arabia with high accuracy',
  //   postBy: "Yasser Abubaker",
  //   createdDate: "1 hours ago",
  //   numberOfoffers: "13 offers",
  // ),
  // ProjectModel(
  //   titleProject: 'health club design',
  //   categoryProject: '',
  //   descriptionProject:
  //       'Interior design of a health club (SPA) of about 8 m by 8 m already built, including a salt cave, Moroccan bath, massage, jacuzzi, sauna, toilet and dressing room',
  //   postBy: "Omer Ali",
  //   createdDate: "15 hours ago",
  //   numberOfoffers: "5 offers",
  // ),
  // ProjectModel(
  //   titleProject: '3D design for interior design',
  //   categoryProject: '',
  //   descriptionProject:
  //       'Project details Project detailsProject details Project details Project details Project detailsProject details',
  //   postBy: "Ahmed osman",
  //   createdDate: "2 days ago",
  //   numberOfoffers: "add first offers",
  // )
  // ];
