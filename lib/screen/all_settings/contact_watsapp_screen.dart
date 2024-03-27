import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/controller/fag_controller.dart';
import 'package:your_engineer/enum/all_enum.dart';
import 'package:your_engineer/widget/shared_widgets/handling_data_view.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWatsappScreen extends StatefulWidget {
  const ContactWatsappScreen({super.key});

  @override
  State<ContactWatsappScreen> createState() => _ContactWatsappScreenState();
}

class _ContactWatsappScreenState extends State<ContactWatsappScreen> {
  FaqController controller = Get.find();
  @override
  initState() {
    Future.delayed(Duration(), () {
      controller.getContactNumber();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.whatsappPhoneNumber.isNotEmpty) {
      goToWatsapp();
    }

    return Scaffold(
      body: GetBuilder<FaqController>(builder: (_) {
        return HandlingDataView(
          loadingState: controller.loadingPhoneNumber,
          errorMessage: controller.errorMessage,
          sizedBoxHeight: Get.height / 3,
          shimmerType: ShimmerType.shimmerListRectangular,
          tryAgan: () => controller.getContactNumber(),
          widget: InkWell(
            onTap: () => goToWatsapp(),
            child: Center(
              child: TextWidget(
                  title: "اضغط للانتقال الي الواتساب"
                          "\n \n" +
                      controller.whatsappPhoneNumber,
                  fontSize: 20,
                  color: Colors.blue),
            ),
          ),
        );
      }),
    );
  }

  void goToWatsapp() {
    launchUrl(
        mode: LaunchMode.externalApplication,
        Uri.parse("whatsapp://send?phone=${controller.whatsappPhoneNumber}"));
  }
}
