// //PrivacyPolicyScreen
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/controller/fag_controller.dart';

import '../../app_config/app_config.dart';
import '../../enum/all_enum.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';

//PrivacyPolicyScreen
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  FaqController controller = Get.put(FaqController());

  @override
  void initState() {
    controller.getPrivacyPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: Obx(() {
        if (controller.loadingState.value == LoadingState.initial ||
            controller.loadingState.value == LoadingState.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.loadingState.value == LoadingState.error ||
            controller.loadingState.value == LoadingState.noDataFound) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${controller.message}"),
              ReyTryErrorWidget(
                  title:
                      controller.loadingState.value == LoadingState.noDataFound
                          ? AppConfig.noData.tr
                          : controller.apiResponse.message,
                  onTap: () {
                    controller.getFaq();
                  })
            ],
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextWidget(
                  title: controller.privacyPolicyModel.description,
                  isTextStart: true,
                  fontSize: Get.height * .02,
                  color: Colors.black),
            ),
          );
        }
      }),
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.privacyPolicy.tr,
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
