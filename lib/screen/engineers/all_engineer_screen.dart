//AllEngineerScreen

import 'package:flutter/material.dart';
import 'package:your_engineer/widget/lis_top_engineer_rating_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../app_config/app_config.dart';

class AllEngineersScreen extends StatelessWidget {
  const AllEngineersScreen({
    Key? key,
    required this.listEngineers,
    required this.colorScheme,
    required this.size,
  }) : super(key: key);
  final List<dynamic> listEngineers;
  final ColorScheme colorScheme;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(context),
        body: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1 / .8,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemCount: listEngineers.length,
          itemBuilder: (ctx, index) {
            // return Text("data");
            return ListTopEngineerRatingWidget(
              fit: BoxFit.cover,
              topEngineerRatingModel: listEngineers[index],
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
            title: AppConfig.engineer, fontSize: 18, color: Colors.white),
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
