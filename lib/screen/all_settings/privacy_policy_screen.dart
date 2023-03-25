// //PrivacyPolicyScreen
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/controller/fag_controller.dart';

import '../../app_config/app_config.dart';
import '../../enum/all_enum.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';

//PrivacyPolicyScreen
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  FaqController controller = Get.put(FaqController());
  bool _expand = false;

  @override
  void initState() {
    controller.getPrivacyPolicy();
    super.initState();
  }

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
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextWidget(
                        title: controller.privacyPolicyModel.description,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  // child: Column(
                  //   children: [

                  //     // ListView.builder(
                  //     //   shrinkWrap: true,
                  //     //   itemCount: controller.faq.length,
                  //     //   itemBuilder: (context, index) {
                  //     //     return FAQWidget(
                  //     //       faqModel: controller.faq[index],
                  //     //       expand: _expand,
                  //     //       onTap: () {
                  //     //         // setState(() {
                  //     //         //   _expand = !_expand;
                  //     //         // });
                  //     //       },
                  //     //     );
                  //     //   },
                  //     // ),
                  //   ],
                  // ),
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
            title: AppConfig.privacyPolicy.tr,
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

// import 'package:flutter/material.dart';

// import '../../app_config/app_config.dart';
// import '../../model/faq_model.dart';
// import '../../widget/shared_widgets/faq_widget.dart';
// import '../../widget/shared_widgets/text_widget.dart';

// class PrivacyPolicyScreen extends StatefulWidget {
//   const PrivacyPolicyScreen({Key? key}) : super(key: key);

//   @override
//   State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
// }

// class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
//   bool _expand = false;
//   // List<FAQModel> faqList = [
//   //   FAQModel(
//   //     title: "كيف يتعامل التطبيق مع المعلومات التي تزودنا بها؟",
//   //     discreption:
//   //         "يلتزم التطبيق بتأمين خصوصيتك حين تزور موقعنا وتتواصل معنا إلكترونيًا. هذه الصفحة توضح الوجه الذي سيتم عبره استخدام أي معلومات شخصية تزودنا بها خلال تواجدك في التطبيق.",
//   //   ),
//   //   FAQModel(
//   //       title: "المسؤولية القانونية",
//   //       discreption:
//   //           "يقر المُستخدِم بأنه المسؤول الوحيد عن طبيعة الاستخدام الذي يحدده التطبيق، وتخلي إدارة التطبيق طرفها، إلى أقصى مدى يجيزه القانون، من كامل المسؤولية عن أية خسائر أو أضرار أو نفقات أو مصاريف يتكبدها المُستخدِم أو يتعرض لها هو أو أي طرف آخر من جراء استخدام التطبيق أو العجز عن استخدامه."),
//   //   FAQModel(
//   //     title: "حالات انقطاع الخدمة في التطبيق",
//   //     discreption:
//   //         "تبذل إدارة التطبيق قصارى جهدها للحرص والحفاظ على استمرار عمل التطبيق  بدون مشاكل، رغم ذلك قد تقع في أي وقت أخطاء وحالات سهو وانقطاع للخدمة وتأخير لها، وفي مثل هذه الحالات سنتوقع من المستخدمين الصبر حتى تعود الخدمة إلى معدلها الطبيعي. ",
//   //   ),
//   //   FAQModel(
//   //       title: "جمع بيانات المستخدمين والأمان",
//   //       discreption:
//   //           "يختار المشترك كلمة سر / مرور لحسابه، وسيُدخل عنوانا بريديا خاصا به لمراسلته عليه، وتكون مسؤولية حماية كلمة السر هذه وعدم مشاركتها أو نشرها على المشترك، وفي حال حدوث أي معاملات باستخدام كلمة السر هذه فسيتحمل المشترك كافة المسؤوليات المترتبة على ذلك، دون أدنى مسؤولية على التطبيق. \n يتحمل المشترك كامل المسؤولية عن جميع المحتويات الخاصة به، التي يرفعها وينشرها عبر التطبيق. \n لا يمكن للمشترك حذف حسابه من التطبيق بأي وسيلة ولا تعديل اسم المستخدم لحسابه، بسبب تعلق الحساب بأمور مالية وحقوق مستخدمين آخرين يمكن الرجوع لها في أي وقت.  "),
//   //   FAQModel(
//   //       title: 'التسجيل في التطبيق',
//   //       discreption:
//   //           'بعض أجزاء التطبيق لا تفتح إلا للأعضاء المشتركين المسجلين بعد تقديم بعض المعلومات الشخصية عنهم. يوافق المشترك عند تسجيله مع التطبيق بأن المعلومات المقدمة هي كاملة ودقيقة، ويلتزم بأنه لن يقوم بالتسجيل في التطبيق ولن يحاول دخوله منتحلاً اسم مشترك آخر ولن يستخدم اسماً قد ترى الإدارة أنه غير مناسب، أو غير ملائم، مثل أرقام الهواتف، والأسماء المنتحلة لشخصيات شهيرة، وروابط المواقع، والأسماء غير المفهومة، وما في حكمها.'),
//   //   FAQModel(
//   //       title: 'الرقابة على المحتوى',
//   //       discreption:
//   //           'تحتفظ إدارة التطبيق  بالحق في مراقبة أي محتوى يدخله المشترك، دون أن يكون ذلك لزاما عليها، لذا تحتفظ بالحق (من دون التزام) في حذف أو إزالة أو تحرير أي مواد مدخلة من شأنها انتهاك شروط وأحكام التطبيق دون الرجوع للمستخدم.إن قوانين حقوق النشر والتأليف المحلية و العالمية والأجنبية والمعاهدات الدولية تحمي جميع محتويات هذا التطبيق، ومن خلال الاشتراك فيه فإن المشترك يوافق ضمنيا وبشكل صريح على الالتزام بإشعارات حقوق النشر التي تظهر على صفحاته.'),
//   //   FAQModel(
//   //       title: 'استخدام ومشاركة المعلومات',
//   //       discreption:
//   //           'يتم التعامل مع جميع المعلومات التي يزودها المستخدمين بسرية تامة ولا يتم بيعها أو مشاركتها مع أي طرف ثالث غير مخوّل بالوصول إليها. حالات استخدام المعلومات:'),
//   //   FAQModel(title: '', discreption: ''),
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     ColorScheme colorScheme = Theme.of(context).colorScheme;
//     final size = MediaQuery.of(context).size;

//     /*
    
 

 

// التسجيل في التطبيق
// بعض أجزاء التطبيق لا تفتح إلا للأعضاء المشتركين المسجلين بعد تقديم بعض المعلومات الشخصية عنهم. يوافق المشترك عند تسجيله مع التطبيق بأن المعلومات المقدمة هي كاملة ودقيقة، ويلتزم بأنه لن يقوم بالتسجيل في التطبيق ولن يحاول دخوله منتحلاً اسم مشترك آخر ولن يستخدم اسماً قد ترى الإدارة أنه غير مناسب، أو غير ملائم، مثل أرقام الهواتف، والأسماء المنتحلة لشخصيات شهيرة، وروابط المواقع، والأسماء غير المفهومة، وما في حكمها.

 

// استخدام ومشاركة المعلومات
// يتم التعامل مع جميع المعلومات التي يزودها المستخدمين بسرية تامة ولا يتم بيعها أو مشاركتها مع أي طرف ثالث غير مخوّل بالوصول إليها. حالات استخدام المعلومات:

// تطوير الخدمات التي يقدمها التطبيق وخدمات شركتنا المختلفة.

// في حال التعاقد مع طرف ثالث لتطوير الخدمات التي نقدمها بعد الالتزام بعدم مشاركة أي معلومات تتعارض مع بيان الخصوصية هذا.

// إذا كنا ملزمين قانونيا بأمر قضائي بالكشف عن أي معلومات.

 

// الرقابة على المحتوى
// تحتفظ إدارة موقع التطبيق  بالحق في مراقبة أي محتوى يدخله المشترك، دون أن يكون ذلك لزاما عليها، لذا تحتفظ بالحق (من دون التزام) في حذف أو إزالة أو تحرير أي مواد مدخلة من شأنها انتهاك شروط وأحكام التطبيق دون الرجوع للمستخدم.
// إن قوانين حقوق النشر والتأليف المحلية و العالمية والأجنبية والمعاهدات الدولية تحمي جميع محتويات هذا التطبيق، ومن خلال الاشتراك فيه فإن المشترك يوافق ضمنيا وبشكل صريح على الالتزام بإشعارات حقوق النشر التي تظهر على صفحاته.

 

// هذه السياسة محل تغيير دائم وتطوير، مع إشعار المشتركين والزوار بذلك، وعلى المشتركين مراجعة هذه السياسات بشكل دوري
//     */
//     return Scaffold(
//       appBar: _getAppBar(context),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: faqList.length,
//               itemBuilder: (context, index) {
//                 return FAQWidget(
//                   faqModel: faqList[index],
//                   expand: _expand,
//                   onTap: () {
//                     setState(() {
//                       _expand = !_expand;
//                     });
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),

//       /*  body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//           child: Column(
//             children: [
//               AnimatedTextWIthCard(
//                 title: AppConfig.privacyPolicy,
//                 discreption: AppConfig.text2,
//                 expand: _expand1,
//                 onTap: () {
//                   setState(() {
//                     _expand1 = !_expand1;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     */
//     );
//   }

//   _getAppBar(BuildContext context) {
//     return AppBar(
//       title: const Padding(
//         padding: EdgeInsets.only(top: 10),
//         child: TextWidget(
//             title: AppConfig.privacyPolicy, fontSize: 18, color: Colors.white),
//       ),
//       leading: IconButton(
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         icon: const Icon(Icons.navigate_before, size: 40),
//         color: Colors.white,
//       ),
//     );
//   }
// }
