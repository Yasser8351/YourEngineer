import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';

import '../model/project_model.dart';
import '../screen/project/add_project_screen.dart';
import '../screen/project/offer_screen.dart';
import 'shared_widgets/card_decoration.dart';
import 'shared_widgets/text_widget.dart';

class ListProjectWidget extends StatelessWidget {
  const ListProjectWidget(
      {Key? key,
      required this.projectModel,
      required this.colorScheme,
      required this.size,
      required this.isMyProject})
      : super(key: key);
  final ProjectModel projectModel;
  final ColorScheme colorScheme;
  final Size size;
  final bool isMyProject;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {
          log("navigatorToNewScreen");
          if (isMyProject) {
            //go to edit my proget Screen

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddProjectScreen(
                projectModel: projectModel,
                isMyProject: true,
              ),
            ));
          } else {
            //go to  Add offer Screen

            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => OffersScreen(
                        projectModel: projectModel,
                      )),
            );
          }
        },
        height: size.height * .29,
        width: size.width * .7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                projectModel.titleProject,
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
                projectModel.descriptionProject,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  color: colorScheme.onSecondary,
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
                      buildRowList(
                        projectModel.postBy,
                        colorScheme,
                        projectModel.postBy.contains("Open")
                            ? Icons.open_in_browser
                            : projectModel.postBy.contains("In progress")
                                ? Icons.blinds
                                : projectModel.postBy.contains("Close")
                                    ? Icons.close
                                    : Icons.local_dining,
                      ),
                      buildRowList(projectModel.createdDate, colorScheme,
                          Icons.watch_later),
                      buildRowList(
                          isMyProject
                              ? projectModel.numberOfoffers
                                      .contains('add first offers')
                                  ? "0"
                                  : projectModel.numberOfoffers
                              : projectModel.numberOfoffers,
                          colorScheme,
                          Icons.post_add),
                    ],
                  ),
                  isMyProject
                      ? CardWithImage(
                          height: size.height * .05,
                          width: size.width * .1,
                          colors: const Color.fromARGB(255, 184, 184, 184),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddProjectScreen(
                                  projectModel: projectModel,
                                  isMyProject: true,
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ))
                      : const SizedBox()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

buildRowList(title, ColorScheme colorScheme, icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
          color: colorScheme.primary,
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: TextWidget(
            title: title,
            fontSize: 15,
            color: colorScheme.secondary,
          ),
        ),
      ],
    ),
  );
}
