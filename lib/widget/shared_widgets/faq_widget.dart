import 'package:flutter/material.dart';
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
    // return AnimatedTextWIthCard(
    //   title: faqModel.title,
    //   discreption: faqModel.discreption,
    //   expand: expand,
    //   onTap: onTap,
    // );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          faqModel.question!,
          textAlign: TextAlign.end,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            faqModel.answer!,
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }
}
