import 'package:flutter/material.dart';
import 'package:your_engineer/widget/no_data.dart';

import '../app_config/app_config.dart';
import '../app_config/app_image.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: NoData(
          textMessage: AppConfig.noMessageYet,
          imageUrlAssets: AppImage.noData,
          onTap: (() {}),
        ),
      ),
    );
  }
}
