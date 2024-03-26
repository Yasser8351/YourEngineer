import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginated_list/paginated_list.dart';
import 'package:your_engineer/screen/engineers/all_engineer_screen.dart';
import 'package:your_engineer/widget/shared_widgets/no_data.dart';

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
    notificationController.getNotificationMore();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          if (controller.loadingState.value == LoadingState.noDataFound)
            return NoData(
              textMessage: "ليس لديك اشعارات",
            );
          else if (controller.loadingState.value == LoadingState.initial ||
              controller.loadingState.value == LoadingState.loading) {
            return ShimmerWidget(size: size);
          } else if (controller.loadingState.value == LoadingState.error ||
              controller.loadingState.value == LoadingState.noDataFound) {
            return ReyTryErrorWidget(
                title: AppConfig.errorOoccurred.tr,
                onTap: () {
                  controller.getNotificationMore();
                });
          } else {
            log(notificationController.results.length.toString());
            // return ListView.separated(
            //   shrinkWrap: true,
            //   separatorBuilder: (context, index) => const Divider(),
            //   itemCount: notificationController.results.length,
            //   itemBuilder: (context, index) {
            return PaginatedList(
              shrinkWrap: true,
              loadingIndicator: handlingPaginationLoading(
                  length: notificationController.results.length,
                  totalCount: controller.totalItems),
              padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
              items: notificationController.results,
              isRecentSearch: false,
              isLastPage: false,
              onLoadMore: (index) {
                controller.getNotificationMore();
              },
              builder: (item, int index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: notificationController.results[index].title,
                            middleText: notificationController
                                .results[index].description,
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
                    ),
                    const Divider(),
                  ],
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

/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liper/controller/notification/user_notification_controller.dart';
import 'package:liper/shared_widgets/notifcation_widget.dart';
import 'package:liper/shared_widgets/ui_helper/handling_data_view.dart';
import 'package:liper/utilits/all_enum.dart';
import 'package:liper/utilits/app_config.dart';
import 'package:paginated_list/paginated_list.dart';

import '../../../utilits/app_ui_helpers.dart';
import '../../../utilits/methode_helper.dart';

class UserNotifcationScreen extends StatefulWidget {
  const UserNotifcationScreen({Key? key}) : super(key: key);

  @override
  State<UserNotifcationScreen> createState() => _UserNotifcationScreenState();
}

class _UserNotifcationScreenState extends State<UserNotifcationScreen> {
  UserNotificationController userNotificationController = Get.find();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      userNotificationController.getNotifications();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(userNotificationController.listNotifications.totalPages.toString());
    log(userNotificationController.listNotifications.totalCount.toString());
    return Scaffold(
      appBar: AppBarLiper(title: AppConfig.notifcation.tr),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
            child: Column(
              children: [
                verticalSpaceRegular,
                GetBuilder<UserNotificationController>(
                  builder: (controller) {
                    return HandlingDataView(
                      shimmerType: ShimmerType.shimmerListRectangular,
                      loadingState: controller.loadingState,
                      tryAgan: () => controller.getNotifications(),
                      sizedBoxHeight: Get.height / 4,
                      errorMessage: controller.errorMessage,
                      widget: RefreshIndicator(
                        onRefresh: () => controller.getNotifications(),
                        child: PaginatedList(
                          shrinkWrap: true,
                          loadingIndicator: handlingPaginationLoading(
                              length: controller
                                  .listNotifications.notifications.length,
                              totalCount:
                                  controller.listNotifications.totalCount),
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 0, left: 10, right: 10),
                          items: controller.listNotifications.notifications,
                          isRecentSearch: false,
                          isLastPage: false,
                          onLoadMore: (index) {
                            controller.getNotificationMore();
                          },
                          builder: (item, int index) => NoticationWidget(
                              userNotificationController:
                                  userNotificationController,
                              notifcationModel: controller
                                  .listNotifications.notifications[index],
                              index: index),
                        ),
                        // child: ListView.builder(
                        //   physics: NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount:
                        //       controller.listNotifications.notifications.length,
                        //   padding: EdgeInsets.all(0),
                        //   itemBuilder: (context, index) => NoticationWidget(
                        //       userNotificationController:
                        //           userNotificationController,
                        //       notifcationModel: controller
                        //           .listNotifications.notifications[index],
                        //       index: index),
                        // ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/