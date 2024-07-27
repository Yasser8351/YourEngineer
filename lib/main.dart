import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/binding/binding_app.dart';
import 'package:your_engineer/controller/app_language_controller.dart';
import 'package:your_engineer/screen/all_settings/faq_screen.dart';
import 'package:your_engineer/screen/all_settings/privacy_policy_screen.dart';
import 'package:your_engineer/screen/login_screen.dart';
import 'package:your_engineer/screen/profile/add_protofilo.dart';
import 'package:your_engineer/screen/project/add_project_screen.dart';
import 'package:your_engineer/screen/all_settings/support_chat_screen.dart';
import 'package:your_engineer/screen/forgot_password_screen.dart';
import 'package:your_engineer/screen/language_screen.dart';
import 'package:your_engineer/screen/notifcation_screen.dart';
import 'package:your_engineer/screen/profile/pay_with_visa.dart';
import 'package:your_engineer/screen/splash_screen.dart';
import 'package:your_engineer/utilits/app_info.dart';
import 'package:your_engineer/utilits/localization/app_localization.dart';

import 'debugger/my_debuger.dart';
import 'screen/project/edit_my_project_screen.dart';
import 'screen/services/services_detail_screen.dart';
import 'screen/services/sub_services_screen.dart';
import 'screen/sign_up_screen.dart';
import 'screen/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupNotifcation();
  var pref = await SharedPreferences.getInstance();

  AppInfo.initAppInfo(
    accountType: pref.getString("status"),
    userId: pref.getString("id"),
    // currentLocale: PrefRepo(pref).preferredLocale,
  );

  runApp(const MyApp());
}

setupNotifcation() async {
  try {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    await FirebaseMessaging.onMessageOpenedApp;
    await FirebaseMessaging.instance.getInitialMessage();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      myLog("onMessageOpenedApp", message);
    });
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  } catch (e) {}
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppLanguageContoller contoller = Get.put(AppLanguageContoller());
    return GetMaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Changa',
        colorScheme: const ColorScheme(
          primary: Color(0xff1DBF73),
          onPrimary: Color.fromARGB(255, 1, 71, 38),
          secondary: Color(0xff999999),
          onSecondary: Color(0xff555555),
          background: Color(0xff0E0E0E),
          surface: Colors.white,
          error: Color(0xff636363), //////////////////
          onError: Colors.red,
          onBackground: Colors.black,
          // Colors.grey[350],
          //#636363
          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
        primarySwatch: Colors.blue,
      ),
      locale: contoller.local ?? Get.deviceLocale,
      translations: AppLocalization(),
      // home: const AddReviewScreen(),
      home: const SplashScreen(),
      initialBinding: BinindingApp(),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: AppRouting.splashScreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          // name: AppRouting.tabScreen,
          name: '/',

          page: () => TabScreen(),
        ),
        GetPage(
          name: AppRouting.loginScreen,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: AppRouting.signUp,
          page: () => const SignUpScreen(),
        ),
        GetPage(
          name: AppRouting.forgetPassword,
          page: () => const ForgotPasswordScreen(),
        ),
        GetPage(
          name: AppRouting.addProjectScreen,
          page: () => AddProjectScreen(),
        ),
        GetPage(
          name: AppRouting.profileUser,
          page: () => const AddProtofiloScreen(),
        ),
        GetPage(
          name: AppRouting.addProtofilo,
          page: () => const AddProtofiloScreen(),
        ),
        // GetPage(
        //   name: AppRouting.addProtofilo,
        //   page: () => const ChatRoomScreen22222(),
        // ),
        // GetPage(
        //   name: AppRouting.profileEngineer,
        //   page: () => ProfileEngineerScreen(
        //       engineerModel: TopEngineerRatingModel(
        //     aboutUser: '',
        //     specialization: '',
        //     user: User(id: '', email: "", fullname: '', phone: '', imgPath: ''),
        //   )),
        // ),
        GetPage(
          name: AppRouting.paypal,
          page: () => const PayWithPaypal(),
        ),
        GetPage(
          name: AppRouting.support,
          page: () => const SupportChatScreen(),
        ),
        GetPage(
          name: AppRouting.notifcation,
          page: () => const NotifcationScreen(),
        ),
        // GetPage(
        //   name: AppRouting.chatRoom,
        //   page: () => const ChatRoomScreen(
        //       image: '',
        //       receiverName: '',
        //       receiverId: '',
        //       senderId: '',
        //       receiverEmail: ''), //receiverName: ''
        // ),
        GetPage(
          name: AppRouting.language,
          page: () => const LanguageScreen(),
        ),

        GetPage(
          name: AppRouting.subServices,
          page: () => const SubServicesScreen(),
        ),
        GetPage(
          name: AppRouting.servicesDetail,
          page: () => const ServicesDetailScreen(),
        ),
        GetPage(
          name: AppRouting.editMyProject,
          page: () => const EditMyProjectScreen(),
        ),
        GetPage(
          name: AppRouting.fag,
          page: () => const FAQScreen(),
        ),
        GetPage(
          name: AppRouting.privacyPolicy,
          page: () => const PrivacyPolicyScreen(),
        ),
        GetPage(
          name: AppRouting.addProjectScreen,
          page: () => const AddProjectScreen(),
        ),
      ],
    );
  }
}
