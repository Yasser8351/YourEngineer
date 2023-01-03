import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/binding/binding_app.dart';
import 'package:your_engineer/controller/app_language_controller.dart';
import 'package:your_engineer/model/project_model.dart';
import 'package:your_engineer/model/top_engineer_rating_model.dart';
import 'package:your_engineer/screen/login_screen.dart';
import 'package:your_engineer/screen/profile/add_protofilo.dart';
import 'package:your_engineer/screen/project/add_project_screen.dart';
import 'package:your_engineer/screen/all_settings/support_chat_screen.dart';
import 'package:your_engineer/screen/forgot_password_screen.dart';
import 'package:your_engineer/screen/language_screen.dart';
import 'package:your_engineer/screen/notifcation_screen.dart';
import 'package:your_engineer/screen/profile/pay_with_visa.dart';
import 'package:your_engineer/screen/profile/profile_engineer_screen.dart';
import 'package:your_engineer/screen/profile/profile_user_screen.dart';
import 'package:your_engineer/screen/splash_screen.dart';
import 'package:your_engineer/utilits/localization/app_localization.dart';

import 'screen/chat/chat_room_screen.dart';
import 'screen/project/edit_my_project_screen.dart';
import 'screen/project/offer_screen.dart';
import 'screen/services/services_detail_screen.dart';
import 'screen/services/sub_services_screen.dart';
import 'screen/sign_up_screen.dart';
import 'screen/tab_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppLanguageContoller contoller = Get.put(AppLanguageContoller());
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Changa',
        colorScheme: const ColorScheme(
          primary: Color(0xff1DBF73),
          onPrimary: Color.fromARGB(255, 1, 71, 38),
          secondary: Color(0xff999999),
          onSecondary: Color(0xff555555),
          background: Color(0xff0E0E0E),
          surface: Colors.white,
          error: Color(0xff636363),
          //////////////////////////////
          onError: Colors.black54,
          onBackground: Colors.black,
          //#636363

          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
        primarySwatch: Colors.blue,
      ),
      locale: contoller.local ?? Get.deviceLocale,
      translations: AppLocalization(),
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

          page: () => const TabScreen(),
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
          page: () => AddProjectScreen(
            projectModel: ProjectModel(
                totalItems: 0, results: [], totalPages: 0, currentPage: 0),
            // projectModel: ProjectModel(
            //     titleProject: '',
            //     categoryProject: '',
            //     descriptionProject: '',
            //     postBy: '',
            //     createdDate: '',
            //     numberOfoffers: ''
            //     ),
          ),
        ),
        GetPage(
          name: AppRouting.profileUser,
          page: () => const AddProtofiloScreen(),
        ),
        GetPage(
          name: AppRouting.addProtofilo,
          page: () => const AddProtofiloScreen(),
        ),
        GetPage(
          name: AppRouting.profileEngineer,
          page: () => ProfileEngineerScreen(
              engineerModel: TopEngineerRatingModel(
            aboutUser: '',
            specialization: '',
            user: User(id: '', email: "", fullname: '', phone: '', imgPath: ''),
          )),
        ),
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
        GetPage(
          name: AppRouting.chatRoom,
          page: () => const ChatRoomScreen(),
        ),
        GetPage(
          name: AppRouting.language,
          page: () => const LanguageScreen(),
        ),
        GetPage(
          name: AppRouting.offerScreen,
          page: () => OffersScreen(
            projectModel: Project(
                titleProject: '',
                categoryProject: '',
                descriptionProject: '',
                postBy: '',
                createdDate: '',
                numberOfoffers: ''),
          ),
        ),
        GetPage(
          name: AppRouting.subServices,
          page: () =>
              const SubServicesScreen(titleServices: '', listSubServices: []),
        ),
        GetPage(
          name: AppRouting.servicesDetail,
          page: () => const ServicesDetailScreen(),
        ),
        GetPage(
          name: AppRouting.editMyProject,
          page: () => const EditMyProjectScreen(),
        ),
      ],
    );
  }
}
