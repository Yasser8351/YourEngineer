import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_config/app_config.dart';
import '../controller/notification_controller.dart';
import '../enum/all_enum.dart';
import '../widget/notifcation_widget.dart';
import '../widget/shared_widgets/reytry_error_widget.dart';
import '../widget/shared_widgets/shimmer_widget.dart';
import '../widget/shared_widgets/text_widget.dart';

class NotifcationScreen extends StatefulWidget {
  const NotifcationScreen({Key? key}) : super(key: key);

  @override
  State<NotifcationScreen> createState() => _NotifcationScreenState();
}

class _NotifcationScreenState extends State<NotifcationScreen> {
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    notificationController.getAllNotification();
  }

  // List<Result> notifcationList = [];
  // List<NotifcationModel> notifcationList = [
  //   NotifcationModel(
  //       title: "Get 20% off your first order! use promo code : fires_order",
  //       notifcationDate: "2 days ago"),
  //   NotifcationModel(
  //       title: "Congratulations, the project has been completed successfully",
  //       notifcationDate: "4 days ago"),
  //   NotifcationModel(
  //       title: "\$200 + has been deposited in your account",
  //       notifcationDate: "7 days ago"),
  //   NotifcationModel(
  //       title: "Get 20% off your first order! use promo code : fires_order",
  //       notifcationDate: "2 days ago"),
  //   NotifcationModel(
  //       title: "Congratulations, the project has been completed successfully",
  //       notifcationDate: "4 days ago"),
  //   NotifcationModel(
  //       title: "\$200 + has been deposited in your account",
  //       notifcationDate: "7 days ago"),
  //   NotifcationModel(
  //       title: "Get 20% off your first order! use promo code : fires_order",
  //       notifcationDate: "2 days ago"),
  //   NotifcationModel(
  //       title: "Congratulations, the project has been completed successfully",
  //       notifcationDate: "4 days ago"),
  //   NotifcationModel(
  //       title: "\$200 + has been deposited in your account",
  //       notifcationDate: "7 days ago"),
  // ];
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          if (controller.loadingState.value == LoadingState.initial ||
              controller.loadingState.value == LoadingState.loading) {
            return ShimmerWidget(size: size);
          } else if (controller.loadingState.value == LoadingState.error ||
              controller.loadingState.value == LoadingState.noDataFound) {
            return ReyTryErrorWidget(
                title: AppConfig.errorOoccurred.tr,
                onTap: () {
                  controller.getAllNotification();
                });
          } else {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(),
              itemCount: notificationController.results.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        title: notificationController.results[index].title,
                        middleText:
                            notificationController.results[index].description,
                        cancel: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              AppConfig.ok.tr,
                            )));
                    controller.readNotification(
                        notificationController.results[index].id);
                  },
                  child: NoticationWidget(
                    colorScheme: colorScheme,
                    size: size,
                    notifcationModel: notificationController.results[index],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.notifcation, fontSize: 18, color: Colors.white),
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
