//AllEngineerScreen

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginated_list/paginated_list.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/widget/lis_top_engineer_rating_widget.dart';
import 'package:your_engineer/widget/shared_widgets/all_shimmers_widgets.dart.dart';
import 'package:your_engineer/widget/shared_widgets/handling_data_view.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../../app_config/app_config.dart';
import '../../controller/top_engineer_controller.dart';

class AllEngineersScreen extends StatefulWidget {
  const AllEngineersScreen({
    Key? key,
    // required this.listEngineers,
    required this.colorScheme,
    required this.size,
  }) : super(key: key);
  // final List<dynamic> listEngineers;
  final ColorScheme colorScheme;
  final Size size;

  @override
  State<AllEngineersScreen> createState() => _AllEngineersScreenState();
}

class _AllEngineersScreenState extends State<AllEngineersScreen> {
  TopEngineerController topEngineerController = Get.find();
  initState() {
    topEngineerController.getTopEngineer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: HandlingDataView(
        loadingState: topEngineerController.loadingState.value,
        errorMessage: topEngineerController.message,
        shimmerType: ShimmerType.shimmerListRectangular,
        tryAgan: () => topEngineerController.getTopEngineer(isMore: true),
        widget: Obx(
          () {
            return PaginatedGrid(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: .62,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              onLoadMore: () =>
                  topEngineerController.getTopEngineer(isMore: true),
              shrinkWrap: true,
              loadingIndicator: handlingPaginationLoading(
                  paddingstart: Get.width / 3,
                  length: topEngineerController.modelEngineer.results.length,
                  totalCount: topEngineerController.totalItems),
              isRecentSearch: false,
              isLastPage: false,
              items: topEngineerController.modelEngineer.results,
              builder: (item, int index) => ListTopEngineerRatingWidget(
                fit: BoxFit.cover,
                topEngineerRatingModel:
                    topEngineerController.modelEngineer.results[index],
                colorScheme: widget.colorScheme,
                size: widget.size,
              ),
            );
          },

          // return ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: topEngineerController.modelEngineer.results.length,
          //     itemBuilder: (context, index) {
          //       // return Text(
          //       //     topEngineerController.modelEngineer.results[index].email);
          //       return ListTopEngineerRatingWidget(
          //         fit: BoxFit.cover,
          //         topEngineerRatingModel:
          //             topEngineerController.listTopEngineer[index],
          //         colorScheme: widget.colorScheme,
          //         size: widget.size,
          //       );
          //     }

          //     );

          // if (topEngineerController.loadingState.value == LoadingState.initial ||
          //     topEngineerController.loadingState.value == LoadingState.loading) {
          //   return ShimmerWidgetList(size: widget.size);
          // } else if (topEngineerController.loadingState.value ==
          //     LoadingState.error) {
          //   return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //     ReyTryErrorWidget(
          //         title: topEngineerController.message,
          //         onTap: () {
          //           topEngineerController.getTopEngineer(1, 20);
          //         })
          //   ]);
          // } else {

          // }
        ),
      ),
    );
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

/*

PaginatedList(
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



//////////////////////////////////////////
PaginatedGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: .62,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              // onLoad More Data
              onLoadMore: () => controller.getProductMore(),
              shrinkWrap: true,
              loadingIndicator: handlingPaginationLoading(
                  paddingstart: Get.width / 3,
                  length: controller.allOffers.products.length,
                  totalCount: controller.allOffers.totalCount),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
              items: controller.allOffers.products,
              isRecentSearch: false,
              isLastPage: false,




                        ///////////////////////
*/
handlingPaginationLoading(
    {required int length,
    required int totalCount,
    double? paddingstart,
    bool isTotalCount0 = false}) {
  log("totalCount : " + totalCount.toString());
  log("length : " + length.toString());
  return length == totalCount
      ? SizedBox()
      : isTotalCount0
          ? SizedBox()
          : Padding(
              padding:
                  EdgeInsetsDirectional.only(top: 0, start: paddingstart ?? 0),
              child: Center(child: ShimmerRectangular()),
              // child: Center(child: CircularProgressIndicator(strokeWidth: .9)),
            );
}
