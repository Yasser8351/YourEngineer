import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/controller/populer_services_controller.dart';
import 'package:your_engineer/model/populer_services_model.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import 'shared_widgets/card_decoration.dart';

class ListPopulerServicesWidget extends StatelessWidget {
  const ListPopulerServicesWidget({
    Key? key,
    required this.populerServicesModel,
    required this.colorScheme,
    required this.size,
  }) : super(key: key);
  final PopulerServicesModel populerServicesModel;
  final ColorScheme colorScheme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    PopulerServicesController controller = Get.find();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CardDecoration(
        onTap: () {
          controller.goToSubServicesScreen(
              populerServicesModel.id, populerServicesModel.titleServices);
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => SubServicesScreen(
          //     titleServices: populerServicesModel.id,
          //     listSubServices: const [],
          //   ),
          // )
          // );
        },
        height: 300,
        width: 200,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.network(
              //   populerServicesModel.imageUrlServices,
              //   height: 150,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              Image.asset(
                AppImage.img8,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextWidget(
                    title: populerServicesModel.titleServices,
                    fontSize: 18,
                    color: colorScheme.onSecondary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
