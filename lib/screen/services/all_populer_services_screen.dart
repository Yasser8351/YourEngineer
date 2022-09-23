//AllPopulerServicesScreen

import 'package:flutter/material.dart';
import 'package:your_engineer/model/populer_services_model.dart';
import 'package:your_engineer/screen/services/sub_services_screen.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../app_config/app_config.dart';
import '../../widget/list_populer_services_widget.dart';
import '../../widget/shared_widgets/card_decoration.dart';

class AllPopulerServicesScreen extends StatelessWidget {
  const AllPopulerServicesScreen({
    Key? key,
    required this.listPopulerServices,
    required this.colorScheme,
    required this.size,
  }) : super(key: key);
  final List<PopulerServicesModel> listPopulerServices;
  final ColorScheme colorScheme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(context),
        // body: ListView.separated(
        //   separatorBuilder: (context, index) => const SizedBox(width: 5),
        //   itemCount: listPopulerServices.length,
        //   itemBuilder: (context, index) {
        body: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.35,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemCount: listPopulerServices.length,
          itemBuilder: (ctx, index) {
            return ListPopulerServicesWidget(
              populerServicesModel: listPopulerServices[index],
              colorScheme: colorScheme,
              size: size,
            );
          },
        ));
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.populerServices,
            fontSize: 18,
            color: Colors.white),
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
