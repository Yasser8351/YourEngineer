import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';

import '../model/project_model.dart';
import 'shared_widgets/card_decoration.dart';
import 'shared_widgets/text_widget.dart';

class ListProjectWidget extends StatelessWidget {
  const ListProjectWidget(
      {Key? key,
      required this.projectModel,
      required this.colorScheme,
      required this.size})
      : super(key: key);
  final ProjectModel projectModel;
  final ColorScheme colorScheme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {},
        height: size.height * .3,
        width: size.width * .7,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            projectModel.postBy, colorScheme, Icons.person),
                        buildRowList(projectModel.createdDate, colorScheme,
                            Icons.watch_later),
                        buildRowList(projectModel.numberOfoffers, colorScheme,
                            Icons.post_add),
                      ],
                    ),
                    CardWithImage(
                        height: size.height * .042,
                        width: size.width * .09,
                        //colors: Colors.black,
                        colors: const Color.fromARGB(255, 146, 146, 146),
                        onTap: () {},
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

buildRowList(title, colorScheme, icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
          color: colorScheme.secondary,
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
