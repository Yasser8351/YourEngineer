import 'package:flutter/material.dart';
import 'package:your_engineer/model/faq_model.dart';
import 'package:your_engineer/widget/faq_widget.dart';

import '../../app_config/app_config.dart';
import '../../widget/text_widget.dart';

//FAQScreen
class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  bool _expand = false;
  List<FAQModel> faqList = [
    FAQModel(
        title: "ما هي الرسوم التي يدفعها صاحب المشروع؟",
        discreption:
            "يدفع صاحب المشروع رسوم وسائل الدفع فقط وهي 2.75% وفي حال قرر العميل إعادة المبالغ التي تم شحنها في حسابه فإننا نقوم بإعادة الرسوم أيضا بشكل تلقائي.اما عمولة التطبيق فتحتسب بشكل تنازلي بناءً على قيمة حجم تعاملات المهندس طوال الوقت مع العميل نفسه ويتم اقتطاعها من أرباح المهندس وليس من صاحب المشروع."),
    FAQModel(
        title: "ما هي وسائل الدفع المتاحة",
        discreption: "وسائل الدفع المتاحة هي باي بال، البطاقات الائتمانية."),
    FAQModel(
        title: "متى يتم إغلاق المشروع بشكل تلقائي",
        discreption:
            "بعد مرور 21 يوما من الموافقة على مشروعك سيتم إغلاقه بشكل تلقائي، علما أنه يمكنك التواصل مع المهندسين فيه وتوظيفهم حتى مرور 45 يوما من تاريخ نشر المشروع، كذلك يمكنك في أي وقت إعادة فتح المشروع لتلقي المزيد من العروض."),
  ];

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                return FAQWidget(
                  faqModel: faqList[index],
                  expand: _expand,
                  onTap: () {
                    setState(() {
                      _expand = !_expand;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child:
            TextWidget(title: AppConfig.faq, fontSize: 18, color: Colors.white),
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
