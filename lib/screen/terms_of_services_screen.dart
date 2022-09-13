import 'package:flutter/material.dart';

import '../app_config/app_config.dart';
import '../model/faq_model.dart';
import '../widget/shared_widgets/faq_widget.dart';
import '../widget/shared_widgets/text_widget.dart';

//PrivacyPolicyScreen
class TermsOfServicesScreen extends StatefulWidget {
  const TermsOfServicesScreen({Key? key}) : super(key: key);

  @override
  State<TermsOfServicesScreen> createState() => _TermsOfServicesScreenState();
}

class _TermsOfServicesScreenState extends State<TermsOfServicesScreen> {
  bool _expand = false;
  List<FAQModel> faqList = [
    FAQModel(
        title: "الهدف من التطبيق",
        discreption:
            "يهدف التطبيق لإيجاد منصّة تجارة إلكترونية آمنة تضمن للمستخدمين حقوقهم وتساعد المهندسين على إيجاد مشاريع ينفذونها وتساعد أصحاب المشاريع على إيجاد مهندسين محترفين ينفذون أعمالهم المختلفة. لتحقيق ذلك، نرجو من المستخدمين الكرام الالتزام بالشروط التالية وفهمها جيداً. إن لم تكن موافقاً على أي من الشروط التالية، نرجو ألا تستخدم التطبيق وألا تنشئ حساباً به. باستخدامك للتطبيق أنت تقر على موافقتك الكاملة على هذه الشروط."),
    FAQModel(
        title: "صحة المعلومات التي يزودها المستخدم",
        discreption:
            "يضمن المستخدم أن جميع المعلومات التي يقوم بإضافتها في حسابه في صحيحة تماما، ويتحمل المستخدم كامل المسؤولية عن أي معلومات خاطئة يقوم بإضافتها."),
    FAQModel(
        title: 'عدم إنشاء أكثر من حساب',
        discreption:
            'يلتزم المستخدم بعدم إنشاء أكثر من حساب واحد في التطبيق وفي حال واجه مشكلة في حسابه الأول فعليه المتابعة مع فريق الدعم الفني لحل المشكلة.'),
    FAQModel(
        title: 'عمر المستخدم أكبر من 18 سنة',
        discreption:
            'يلتزم المستخدم المسجل في التطبيق أن عمره أكبر من 18 سنة، وقد يطلب التطبيق وثائق تثبت ذلك في حال دعت الحاجة.'),
    FAQModel(
        title: 'طلب وثائق لتأكيدالحساب',
        discreption:
            'قد يطلب التطبيق وثائق شخصية مثل الهوية أو جواز السفر لإثبات هوية المستخدم .'),
    FAQModel(
        title: 'إيقاف الحساب وطلب وثائق عنه',
        discreption:
            'التطبيق موقع تجاري، قد يقوم فريق التطبيق بإيقاف حساب أي مستخدم يتم الشك فيه أو بمخالفته للشروط، ويحق للتطبيق طلب وثائق شخصية عن المستخدم تثبت هويته لإعادة تفعيل الحساب، كذلك قد يتم طلب وثائق للتأكد من ملكيته لحساب باي بال أو البطاقة الائتمانية.'),
    FAQModel(
        title: 'حقوق التأليف والنشر والملكية الفكرية',
        discreption:
            'بشكل افتراضي، وما لم يتم الاتفاق من قبل بداية المشروع على عكس ذلك، يمتلك صاحب المشروع كامل حقوق الملكية الفكرية وحقوق التأليف والنشر للمشاريع التي استلمها من خلال التطبيق. لا يحق للمهندس فرض حقوق إضافية على المشروع بعد البدء بتنفيذه أو تسليمه.'),
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
              physics: const NeverScrollableScrollPhysics(),
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

      /* 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              AnimatedTextWIthCard(
                title: AppConfig.termsOfServices,
                discreption: AppConfig.text1,
                expand: _expand1,
                onTap: () {
                  setState(() {
                    _expand1 = !_expand1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    */
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.termsOfServices,
            fontSize: 18,
            color: Colors.white),
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
