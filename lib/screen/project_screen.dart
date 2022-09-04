import 'dart:developer';

import 'package:flutter/material.dart';

import '../app_config/app_config.dart';
import '../app_config/app_image.dart';
import '../widget/no_data.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ColorScheme colorScheme = Theme.of(context).colorScheme;
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: NoData(
          isPostScreen: true,
          textMessage: AppConfig.noProjectYet,
          imageUrlAssets: AppImage.noProject,
          onTap: (() {
            log("message");
            //go To AddPostScreen
            Navigator.of(context).pushNamed(AppConfig.addProjectScreen);
          }),
        ),
      ),
    );
  }
}
