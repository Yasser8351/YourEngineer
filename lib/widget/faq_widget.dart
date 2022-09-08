import 'package:flutter/material.dart';
import 'package:your_engineer/model/faq_model.dart';

class FAQWidget extends StatelessWidget {
  const FAQWidget({
    Key? key,
    required this.faqModel,
    required this.onTap,
    required this.expand,
  }) : super(key: key);

  final FAQModel faqModel;
  final Function() onTap;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    // return AnimatedTextWIthCard(
    //   title: faqModel.title,
    //   discreption: faqModel.discreption,
    //   expand: expand,
    //   onTap: onTap,
    // );

    return ListTile(
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(faqModel.title),
      ),
      subtitle: Align(
        alignment: Alignment.centerRight,
        child: Text(faqModel.discreption),
      ),
    );
  }
}
