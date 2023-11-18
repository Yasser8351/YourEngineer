import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/widget/shared_widgets/build_row_list.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';

import '../model/owner_project_model.dart';
import '../screen/project/my_project_offers_screen.dart';
import '../utilits/helper.dart';
import 'shared_widgets/card_decoration.dart';

class ListMyProjectWidget extends StatelessWidget {
  const ListMyProjectWidget(
      {Key? key,
      required this.ownerProjectModel,
      required this.colorScheme,
      required this.size,
      required this.isMyProject})
      : super(key: key);
  final OwnerProjectModel ownerProjectModel;
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
          Get.to(
              () => MyProjectOffersScreen(
                    size: size,
                    colorScheme: colorScheme,
                    projectid: ownerProjectModel.id,
                    ownerProjectModel: ownerProjectModel,
                  ),
              arguments: {'projectId': ownerProjectModel.id});
        },
        height: size.height * .33,
        width: size.width * .7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "اسم المشروع",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size.height * .017,
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ownerProjectModel.projTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size.height * .02,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "وصف المشروع",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size.height * .017,
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ownerProjectModel.projDescription,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size.height * .02,
                  color: colorScheme.primary,
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
                      BuildRowList(
                        title: ownerProjectModel.projStatus!.statName,
                        colorScheme: colorScheme,
                        icon: ownerProjectModel.projStatus!.statName!
                                .contains("Open")
                            ? Icons.open_in_browser
                            : ownerProjectModel.projStatus!.statName!
                                    .contains("In-Progress")
                                ? Icons.blinds
                                : ownerProjectModel.projStatus!.statName!
                                        .contains("Close")
                                    ? Icons.close
                                    : Icons.local_dining,
                        description: "حالة المشروع",
                      ),
                      BuildRowList(
                        title: isMyProject
                            ? ownerProjectModel.offersCount == 0
                                ? "0"
                                : ownerProjectModel.offersCount.toString()
                            : ownerProjectModel.offersCount.toString(),
                        colorScheme: colorScheme,
                        icon: Icons.post_add,
                        description: "عدد العروض",
                      ),
                      BuildRowList(
                        title: ownerProjectModel.priceRange!.rangeName,
                        colorScheme: colorScheme,
                        icon: CupertinoIcons.money_dollar,
                        description: "ميزانية المشروع",
                      ),
                      BuildRowList(
                        title: dateFormat(ownerProjectModel.createdAt),
                        colorScheme: colorScheme,
                        icon: Icons.watch_later,
                        description: "تاريخ الانشاء",
                      ),
                    ],
                  ),
                  isMyProject
                      ? CardWithImage(
                          height: size.height * .05,
                          width: size.width * .1,
                          colors: const Color.fromARGB(255, 184, 184, 184),
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => AddProjectScreen(
                            //       projectModel: projectModel,
                            //       isMyProject: true,
                            //     ),
                            //   ),
                            // );
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

// buildRowList(title, ColorScheme colorScheme, icon, description) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 3),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Icon(
//           icon,
//           size: 20,
//           color: colorScheme.primary,
//         ),
//         const SizedBox(
//           width: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 2),
//           child: TextWidget(
//             title: description,
//             fontSize: 15,
//             color: colorScheme.secondary,
//           ),
//         ),
//         TextWidget(
//           title: "  :  ",
//           fontSize: 15,
//           color: colorScheme.secondary,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 2),
//           child: TextWidget(
//             title: title,
//             fontSize: 15,
//             color: colorScheme.secondary,
//           ),
//         ),
//       ],
//     ),
//   );

// }
