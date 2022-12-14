import 'dart:developer';

import 'package:flutter/material.dart';

import '../../model/project_model.dart';
import '../../model/sub_services_model.dart';
import '../../widget/list_my_project_widget.dart';
import '../../widget/list_sub_services_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';

class SubServicesScreen extends StatefulWidget {
  const SubServicesScreen(
      {Key? key, required this.titleServices, required this.listSubServices})
      : super(key: key);
  final String titleServices;
  final List<SubServicesModel> listSubServices;

  @override
  State<SubServicesScreen> createState() => _SubServicesScreenState();
}

class _SubServicesScreenState extends State<SubServicesScreen> {
  String search = '';
  List<ProjectModel> listProject = [];
  // List<ProjectModel> listProject = [
  //   ProjectModel(
  //     titleProject: '3D design for interior design',
  //     categoryProject: "Electricity Distribution Scheme",
  //     descriptionProject:
  //         'Project details Project detailsProject details Project details Project details Project detailsProject details',
  //     postBy: "Open",
  //     createdDate: "2 days ago",
  //     numberOfoffers: "add first offers",
  //   ),
  //   ProjectModel(
  //     titleProject: 'Making tables of quantities',
  //     categoryProject: "Electricity Distribution Scheme",
  //     descriptionProject:
  //         'Quantity surveying is required for all systems for a small villa in Saudi Arabia with high accuracy',
  //     postBy: "In progress",
  //     createdDate: "1 hours ago",
  //     numberOfoffers: "13 offers",
  //   ),
  //   ProjectModel(
  //     titleProject: 'health club design',
  //     categoryProject: "Electricity Distribution Scheme",
  //     descriptionProject:
  //         'Interior design of a health club (SPA) of about 8 m by 8 m already built, including a salt cave, Moroccan bath, massage, jacuzzi, sauna, toilet and dressing room',
  //     postBy: "Completed",
  //     createdDate: "15 hours ago",
  //     numberOfoffers: "5 offers",
  //   ),
  //   ProjectModel(
  //     titleProject: '3D design for interior design',
  //     categoryProject: "Electricity Distribution Scheme",
  //     descriptionProject:
  //         'Project details Project detailsProject details Project details Project details Project detailsProject details',
  //     postBy: "Open",
  //     createdDate: "2 days ago",
  //     numberOfoffers: "8 offers",
  //   ),
  //   ProjectModel(
  //     titleProject: '3D design for interior design',
  //     categoryProject: "Electricity Distribution Scheme",
  //     descriptionProject:
  //         'Project details Project detailsProject details Project details Project details Project detailsProject details',
  //     postBy: "Open",
  //     createdDate: "2 days ago",
  //     numberOfoffers: "add first offers",
  //   ),
  //   ProjectModel(
  //     titleProject: 'Making tables of quantities',
  //     categoryProject: "Electricity Distribution Scheme",
  //     descriptionProject:
  //         'Quantity surveying is required for all systems for a small villa in Saudi Arabia with high accuracy',
  //     postBy: "In progress",
  //     createdDate: "1 hours ago",
  //     numberOfoffers: "13 offers",
  //   ),
  //   ProjectModel(
  //     titleProject: 'health club design',
  //     categoryProject: "Electricity Distribution Scheme",
  //     descriptionProject:
  //         'Interior design of a health club (SPA) of about 8 m by 8 m already built, including a salt cave, Moroccan bath, massage, jacuzzi, sauna, toilet and dressing room',
  //     postBy: "Completed",
  //     createdDate: "15 hours ago",
  //     numberOfoffers: "5 offers",
  //   ),
  //   ProjectModel(
  //     titleProject: '3D design for interior design',
  //     categoryProject: "Electricity Distribution Scheme",
  //     descriptionProject:
  //         'Project details Project detailsProject details Project details Project details Project detailsProject details',
  //     postBy: "Open",
  //     createdDate: "2 days ago",
  //     numberOfoffers: "8 offers",
  //   ),
  // ];

  int expandeIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context, widget.titleServices),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * .015),

            // List Sub Services horizantial this list using to
            // filter main List by title Sub Services
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                scrollDirection: Axis.horizontal,
                itemCount: widget.listSubServices.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        search = widget.listSubServices[index].title;
                        listProject = listProject.where(
                          (element) {
                            log("element :  ${element.totalItems}");

                            return element.totalItems == search;
                            // return element.categoryProject == search;
                          },
                        ).toList();
                        expandeIndex = index;

                        log("searh :  $search");
                        log("listProject :  ${listProject.length}");
                      });
                    },
                    child: ListSubServicesWidget(
                      subServicesModel: widget.listSubServices[index],
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listProject.length,
              itemBuilder: (context, index) => ListProjectWidget(
                projectModel: listProject[index],
                colorScheme: colorScheme,
                size: size,
                isMyProject: false,
              ),
            ),
          ],
        ),
      ),
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
