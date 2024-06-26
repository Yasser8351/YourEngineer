import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/list_my_project_widget.dart';
import 'package:your_engineer/widget/shared_widgets/card_with_image.dart';

import '../controller/listProject_controller.dart';
import 'shared_widgets/card_decoration.dart';
import 'shared_widgets/text_widget.dart';

class ListProjectWidget extends StatelessWidget {
  const ListProjectWidget({
    Key? key,
    required this.results,
    required this.colorScheme,
    required this.size,
    required this.index,
  }) : super(key: key);
  final dynamic results;
  final ColorScheme colorScheme;
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    ListProjectController controller = Get.put(ListProjectController());

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {
          controller.goToOfferScreen(results);
        },
        height: size.height * .38,
        width: size.width * .8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConfig.projectName.tr + " : " + results['proj_title'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Get.height * .02,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppConfig.descreiption.tr + " : " + results['proj_description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Get.height * .02,
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "المهارات" + " : " + results['skills'].toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Get.height * .02,
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
                      buildRowList(results['owner']['fullname'].toString(),
                          colorScheme, Icons.person),
                      buildRowList(
                          results['proj_period'].toString() +
                              " " +
                              AppConfig.dayProject.tr,
                          colorScheme,
                          Icons.watch_later),
                      buildRowList(
                          AppConfig.priceRange.tr +
                              ": " +
                              results['PriceRange']['range_name'].toString(),
                          colorScheme,
                          Icons.person),
                      results['skills'].toString == ''
                          ? buildRowList(results['skills'].toString(),
                              colorScheme, Icons.person)
                          : SizedBox(),
                      buildRowList(
                          GetTimeAgo.parse(
                              DateTime.parse(results['CreatedAt'].toString()),
                              pattern: "dd-MM-yyyy hh:mm aa",
                              locale: 'ar'),

                          // buildRowList(dateFormat(results['CreatedAt']),
                          colorScheme,
                          Icons.today),
                      buildRowList(
                        getTitleStatusProject(
                            results['ProjStatus']['stat_name'].toString()),
                        colorScheme,
                        getIconStatusProject(
                            results['ProjStatus']['stat_name'].toString()),
                      ),
                      buildRowList(
                        AppConfig.offerCount.tr +
                            " " +
                            results['OffersCount'].toString(),
                        colorScheme,
                        Icons.post_add,
                      ),
                    ],
                  ),
                  CardWithImage(
                      height: size.height * .042,
                      width: size.width * .09,
                      //colors: Colors.black,
                      colors: colorScheme.primary,
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
