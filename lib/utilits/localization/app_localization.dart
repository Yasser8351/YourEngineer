import 'package:get/get.dart';

import '../../app_config/app_config.dart';

class AppLocalization implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          AppConfig.appName: "Architect",
          AppConfig.engineer: "مهندس",
          AppConfig.noProjectsFound: "لاتوجد مشاريع",
          AppConfig.withKeySearch: "تطابق نتائج البحث",
          AppConfig.projectOwner: "صاحب مشروع",
          AppConfig.emal: "الايميل",
          AppConfig.phone: "رقم الهاتف",
          AppConfig.password: "كلمة المرور",
          AppConfig.comfirmPassword: "تأكيد كلمة المرور",
          AppConfig.signUp: "انشاء حساب",
          AppConfig.forgetPassword: "نسيت كلمة المرور؟",
          AppConfig.tabScreen: "",
          AppConfig.addProjectScreen: "اضافة مشروع",
          AppConfig.addProtofilo: "اضافة مشروع الي معرض الاعمال",
          AppConfig.offerScreen: "صفحة العروض",
          AppConfig.paypal: "بايبال",
          AppConfig.visa: "فيزا",
          AppConfig.chatRoom: "الدردشة",
          AppConfig.addSomeProject: "قم باضافة بعض المشاريع",
          AppConfig.notifcation: "الاشعارات",
          AppConfig.profileUser: "الملف الشخصي",
          AppConfig.profileEngineer: "معرص اعمال المهندسين",
          AppConfig.support: "الدعم الفني",
          AppConfig.language: "اللغة",
          AppConfig.noMessageYet: "لاتوجد رسائل",
          AppConfig.noMessageSuppoerYet: "لاتوجد رسائل",
          AppConfig.projectDetails: "تفاصيل المشروع",
          AppConfig.editMyProject: "تعديل المشروع",
          AppConfig.noData: "لاتوجد بيانات",
          AppConfig.send: "ارسال",
          AppConfig.exitApp: "الخروج من التطبيق",
          AppConfig.chat: "الرسائل",
          AppConfig.myProject: "مشاريعي",
          AppConfig.project: "المشاريع",
          AppConfig.price: "السعر",
          AppConfig.descreiption: "الوصف",
          AppConfig.days: "الايام",
          AppConfig.home: "الرئيسية",
          AppConfig.settings: "الاعدادات",
          AppConfig.agreeTotermsOfServices:
              "من خلال التسجيل في التطبيق، فإنك توافق على",
          AppConfig.lastName: "الاسم الاخير",
          AppConfig.firstName: "الاسم الاول",
          AppConfig.signUpWithEmail: "التسجيل عن طريق البريد الإلكتروني",
          AppConfig.timeOut: "يبدو ان اتصال الانترنت لديك ضعيف",
          AppConfig.tryAgain: "اعادة المحاولة",
          AppConfig.login: "تسجيل الدخول",
          AppConfig.chooseCategory: "",
          AppConfig.history: "السجل",
          AppConfig.paymentHistory: "سجل الدفعيات",
          AppConfig.businessFair: "معرض الأعمال",
          AppConfig.reviews: "التقييمات",
          AppConfig.personalProfile: "المعلومات الشخصية",
          AppConfig.servicesDetail: "تفاصيل الخدمات",
          AppConfig.subServices: "الخدمات الفرعية",
          AppConfig.faq: "الأسئلة الشائعة",
          AppConfig.logout: "تسجيل الخروج",
          AppConfig.privacyPolicy: "سياسة الخصوصية",
          AppConfig.termsOfServices: "الشروط والأحكام",
          AppConfig.version: "الاصدار 1.0.0",
          AppConfig.profile: "الملف الشخصي",
          AppConfig.noProjectYet: "لايوجد مشروع",
          AppConfig.search: "بحث",
          AppConfig.allOffer: "كل العروض",
          AppConfig.addOffer: "اضافة عرض",
          AppConfig.sendMessage: "ارسال رسالة",
          AppConfig.submitYourProject: "اضافة المشروع",
          AppConfig.lastProject: "اخر المشاريع",
          AppConfig.seeAll: "عرض الكل",
          AppConfig.aboutme: "وصف مختصر",
          AppConfig.ok: "موافق",
          AppConfig.cannotaddOffer: "حدث خطأ لم يتم اضافة عرضك",
          AppConfig.topEngineerRating: "الأعلي تقييم",
          AppConfig.populerServices: "الأقسام الرئيسية",
          AppConfig.addOfferSuccesfuly: "تم اضافة عرضك",
          AppConfig.projectTitle: "عنوان المشروع",
          AppConfig.skills: "المهارات",
          AppConfig.submitYourProtofilo: "ارسال المشروع",
          AppConfig.resetPassword: "استعادة كلمة المرور",
          AppConfig.allFaildRequired: "جميع الحقول مطلوبة"
        },
        "en": {
          AppConfig.appName: "Architect",
          AppConfig.ok: "OK",
          AppConfig.submitYourProtofilo: "Submit Your Protofilo",
          AppConfig.engineer: AppConfig.engineer,
          AppConfig.projectOwner: AppConfig.projectOwner,
          AppConfig.emal: AppConfig.emal,
          AppConfig.phone: AppConfig.phone,
          AppConfig.password: AppConfig.password,
          AppConfig.comfirmPassword: AppConfig.comfirmPassword,
          AppConfig.signUp: AppConfig.signUp,
          AppConfig.forgetPassword: AppConfig.forgetPassword,
          AppConfig.tabScreen: AppConfig.tabScreen,
          AppConfig.addProjectScreen: AppConfig.addProjectScreen,
          AppConfig.addProtofilo: AppConfig.addProtofilo,
          AppConfig.offerScreen: AppConfig.offerScreen,
          AppConfig.paypal: AppConfig.paypal,
          AppConfig.visa: AppConfig.visa,
          AppConfig.chatRoom: AppConfig.chatRoom,
          AppConfig.addSomeProject: AppConfig.addSomeProject,
          AppConfig.notifcation: AppConfig.notifcation,
          AppConfig.profileUser: AppConfig.profileUser,
          AppConfig.profileEngineer: AppConfig.profileEngineer,
          AppConfig.support: AppConfig.support,
          AppConfig.language: AppConfig.language,
          AppConfig.noMessageYet: AppConfig.noMessageYet,
          AppConfig.noMessageSuppoerYet: AppConfig.noMessageSuppoerYet,
          AppConfig.projectDetails: AppConfig.projectDetails,
          AppConfig.editMyProject: AppConfig.editMyProject,
          AppConfig.noData: AppConfig.noData,
          AppConfig.aboutme: "About me",
          AppConfig.skills: "Skills",
          AppConfig.send: AppConfig.send,
          AppConfig.exitApp: AppConfig.exitApp,
          AppConfig.chat: AppConfig.chat,
          AppConfig.myProject: AppConfig.myProject,
          AppConfig.project: AppConfig.project,
          AppConfig.price: AppConfig.price,
          AppConfig.descreiption: AppConfig.descreiption,
          AppConfig.days: AppConfig.days,
          AppConfig.home: AppConfig.home,
          AppConfig.settings: AppConfig.settings,
          AppConfig.agreeTotermsOfServices: AppConfig.agreeTotermsOfServices,
          AppConfig.lastProject: AppConfig.lastProject,
          AppConfig.lastName: AppConfig.lastName,
          AppConfig.firstName: AppConfig.firstName,
          AppConfig.signUpWithEmail: AppConfig.signUpWithEmail,
          AppConfig.timeOut: AppConfig.timeOut,
          AppConfig.tryAgain: AppConfig.tryAgain,
          AppConfig.login: AppConfig.login,
          AppConfig.chooseCategory: AppConfig.chooseCategory,
          AppConfig.history: AppConfig.history,
          AppConfig.paymentHistory: AppConfig.paymentHistory,
          AppConfig.businessFair: AppConfig.businessFair,
          AppConfig.reviews: AppConfig.reviews,
          AppConfig.personalProfile: AppConfig.personalProfile,
          AppConfig.servicesDetail: AppConfig.servicesDetail,
          AppConfig.subServices: AppConfig.subServices,
          AppConfig.faq: AppConfig.faq,
          AppConfig.logout: AppConfig.logout,
          AppConfig.privacyPolicy: AppConfig.privacyPolicy,
          AppConfig.termsOfServices: AppConfig.termsOfServices,
          AppConfig.version: AppConfig.version,
          AppConfig.profile: AppConfig.profile,
          AppConfig.noProjectYet: AppConfig.noProjectYet,
          AppConfig.search: AppConfig.search,
          AppConfig.allOffer: AppConfig.allOffer,
          AppConfig.addOffer: AppConfig.addOffer,
          AppConfig.sendMessage: AppConfig.sendMessage,
          AppConfig.submitYourProject: AppConfig.submitYourProject,
          AppConfig.seeAll: AppConfig.seeAll,
          AppConfig.topEngineerRating: AppConfig.topEngineerRating,
          AppConfig.populerServices: AppConfig.populerServices,
          AppConfig.allFaildRequired: AppConfig.allFaildRequired,
          AppConfig.cannotaddOffer: "Can not add Offer",
          AppConfig.addOfferSuccesfuly: "add offer Succesfuly",
          AppConfig.noProjectsFound: "No projects found",
          AppConfig.withKeySearch: "with this key",
          AppConfig.resetPassword: "Reset Password",
          AppConfig.projectTitle: "Project title"
        },
      };
}
/* 


*/