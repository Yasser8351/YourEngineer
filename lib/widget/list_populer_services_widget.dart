import 'package:flutter/material.dart';
import 'package:your_engineer/model/populer_services_model.dart';
import 'package:your_engineer/widget/text_widget.dart';

import 'card_decoration.dart';

class ListPopulerServicesWidget extends StatelessWidget {
  const ListPopulerServicesWidget(
      {Key? key,
      required this.populerServicesModel,
      required this.colorScheme,
      required this.size})
      : super(key: key);
  final PopulerServicesModel populerServicesModel;
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
        height: 300,
        width: 200,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                populerServicesModel.imageUrlServices,
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
