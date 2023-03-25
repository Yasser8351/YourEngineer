import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/controller/fag_controller.dart';
import 'package:your_engineer/widget/shared_widgets/faq_widget.dart';

import '../../app_config/app_config.dart';
import '../../enum/all_enum.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';

//FAQScreen
class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  FaqController controller = Get.put(FaqController());
  bool _expand = false;

  @override
  Widget build(BuildContext context) {
    return

        // GetBuilder<FaqController>(
        //     builder: (controller) =>
        Scaffold(
            appBar: _getAppBar(context),
            body:
                //           controller.isloding
                // ? Center(
                //     child: CircularProgressIndicator(),
                //   )
                // :
                Obx(() {
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
                        title: controller.loadingState.value ==
                                LoadingState.noDataFound
                            ? AppConfig.noData.tr
                            : controller.apiResponse.message,
                        onTap: () {
                          controller.getFaq();
                        })
                  ],
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.faq.length,
                        itemBuilder: (context, index) {
                          return FAQWidget(
                            faqModel: controller.faq[index],
                            expand: _expand,
                            onTap: () {
                              // setState(() {
                              //   _expand = !_expand;
                              // });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            }

                    // )
                    ));
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.faq.tr, fontSize: 18, color: Colors.white),
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
