import 'package:flutter/material.dart';
import 'package:your_engineer/widget/card_with_image.dart';

import '../model/project_model.dart';
import 'card_decoration.dart';
import 'text_widget.dart';

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
    // ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {},
        height: size.height,
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
                    fontWeight: FontWeight.w700,
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
                  ),
                ),
                const SizedBox(height: 10),
                // const Spacer(), //use this widget to take the available space

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRowList("Yasser", colorScheme, Icons.person),
                        buildRowList(
                            "15 hours ago", colorScheme, Icons.time_to_leave),
                        buildRowList("13 offers", colorScheme, Icons.money),
                      ],
                    ),
                    CardWithImage(
                        height: size.height * .05,
                        width: size.width * .1,
                        colors: Colors.black,
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
          width: 20,
        ),
        TextWidget(
          title: title,
          fontSize: 15,
          color: colorScheme.secondary,
        ),
      ],
    ),
  );
}
