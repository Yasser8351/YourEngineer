import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:your_engineer/model/faq_model.dart';

class FAQWidget extends StatelessWidget {
  const FAQWidget({
    Key? key,
    required this.faqModel,
    required this.onTap,
    required this.expand,
  }) : super(key: key);

  final FaqtModel faqModel;
  final Function() onTap;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          faqModel.question!,
          style: TextStyle(fontSize: Get.height * .02),
          textAlign: TextAlign.start,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            faqModel.answer!,
            style: TextStyle(fontSize: Get.height * .02),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
