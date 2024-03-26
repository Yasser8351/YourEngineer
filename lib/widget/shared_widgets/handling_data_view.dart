import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/widget/shared_widgets/all_shimmers_widgets.dart.dart';

class HandlingDataView extends StatelessWidget {
  const HandlingDataView({
    Key? key,
    required this.loadingState,
    required this.widget,
    this.shimmerType = ShimmerType.shimmerHorizontal,
    this.tryAgan,
    this.errorMessage,
    this.sizedBoxHeight = 7,
    this.itemCount,
    this.errorMessageColor,
    this.heightRetryWidget,
  }) : super(key: key);
  final LoadingState loadingState;
  final Widget widget;
  final Function()? tryAgan;
  final ShimmerType shimmerType;
  final String? errorMessage;
  final double? heightRetryWidget;
  final double sizedBoxHeight;
  final int? itemCount;
  final Color? errorMessageColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: loadingState == LoadingState.initial ||
      child: loadingState == LoadingState.loading
          ? shimmerType == ShimmerType.shimmerRectangular
              ? ShimmerRectangular()
              : shimmerType == ShimmerType.shimmerListRectangular
                  ? ShimmerListRectangular(itemCount: itemCount)
                  : shimmerType == ShimmerType.shimmerCircular
                      ? ShimmerCircular()
                      : shimmerType == ShimmerType.shimmerHorizontal
                          ? ShimmerHorizontal()
                          : Center(
                              child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CircularProgressIndicator(),
                            ))
          : loadingState == LoadingState.error
              ? RetryWidget(
                  sizedBoxHeight: sizedBoxHeight,
                  height: heightRetryWidget ?? Get.height / 5,
                  errorMessage: errorMessage ?? AppConfig.errorOoccurred.tr,
                  errorMessageColor: errorMessageColor,
                  onTap: tryAgan ?? () {},
                )
              : loadingState == LoadingState.noDataFound
                  ? RetryWidget(
                      sizedBoxHeight: sizedBoxHeight,
                      height: heightRetryWidget ?? Get.height / 5,
                      hideButtonRetry: true,
                      errorMessage: errorMessage ?? AppConfig.errorOoccurred.tr,
                      errorMessageColor: errorMessageColor,
                      onTap: tryAgan ?? () {},
                    )
                  : widget,
    );
  }
}

class RetryWidget extends StatelessWidget {
  const RetryWidget(
      {Key? key,
      required this.errorMessage,
      this.meesageButton,
      required this.onTap,
      this.height,
      this.errorMessageColor,
      this.hideButtonRetry = false,
      this.sizedBoxHeight = 4})
      : super(key: key);
  final bool hideButtonRetry;
  final String errorMessage;
  final String? meesageButton;
  final Function() onTap;

  final double? height;
  final double sizedBoxHeight;
  final Color? errorMessageColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: sizedBoxHeight),
        SizedBox(
          height: height ?? Get.height / .05,
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              //color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: errorMessageColor ?? Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  hideButtonRetry
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: onTap,
                          child: Container(
                            width: Get.width * .45,
                            height: Get.height * .06,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.refresh, color: Colors.white),
                                const SizedBox(width: 10),
                                Text(
                                  meesageButton ?? AppConfig.tryAgain.tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    // return MyText.h4("error");
  }
}
