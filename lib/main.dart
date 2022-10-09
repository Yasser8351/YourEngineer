import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/model/project_model.dart';
import 'package:your_engineer/model/top_engineer_rating_model.dart';
import 'package:your_engineer/screen/profile/add_protofilo.dart';
import 'package:your_engineer/screen/project/add_project_screen.dart';
import 'package:your_engineer/screen/all_settings/support_chat_screen.dart';
import 'package:your_engineer/screen/forgot_password_screen.dart';
import 'package:your_engineer/screen/language_screen.dart';
import 'package:your_engineer/screen/login_screen.dart';
import 'package:your_engineer/screen/notifcation_screen.dart';
import 'package:your_engineer/screen/profile/pay_with_paypal.dart';
import 'package:your_engineer/screen/profile/pay_with_visa.dart';
import 'package:your_engineer/screen/profile/profile_engineer_screen.dart';
import 'package:your_engineer/screen/profile/profile_user_screen.dart';
import 'package:your_engineer/screen/project/edit_my_project_screen.dart';
import 'package:your_engineer/screen/project/offer_screen.dart';
import 'package:your_engineer/screen/services/services_detail_screen.dart';
import 'package:your_engineer/screen/services/sub_services_screen.dart';
import 'package:your_engineer/screen/sign_up_screen.dart';
import 'package:your_engineer/screen/splash_screen.dart';

import 'screen/all_settings/faq_screen.dart';
import 'screen/all_settings/privacy_policy_screen.dart';
import 'screen/chat/chat_room_screen.dart';
import 'screen/terms_of_services_screen.dart';
import 'screen/tab_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const SplashScreen(),
      // home: const TabScreen(),
      routes: {
        AppConfig.login: (ctx) => const LoginScreen(),
        AppConfig.signUp: (ctx) => const SignUpScreen(),
        AppConfig.forgetPassword: (ctx) => const ForgotPasswordScreen(),
        AppConfig.tabScreen: (ctx) => const TabScreen(),
        AppConfig.addProjectScreen: (ctx) => AddProjectScreen(
              projectModel: ProjectModel(
                  titleProject: '',
                  categoryProject: '',
                  descriptionProject: '',
                  postBy: '',
                  createdDate: '',
                  numberOfoffers: ''),
            ),
        AppConfig.profileUser: (ctx) => const ProfileUserScreen(),
        AppConfig.profileEngineer: (ctx) => ProfileEngineerScreen(
            engineerModel: TopEngineerRatingModel(
                engineerName: '',
                engineerspecialist: '',
                imageUrl: '',
                engineerRating: 0.0)),
        AppConfig.paypal: (ctx) => const PayWithPaypal(),
        AppConfig.visa: (ctx) => const PayWithVisa(),
        AppConfig.chatRoom: (ctx) => const ChatRoomScreen(),
        AppConfig.notifcation: (ctx) => const NotifcationScreen(),
        AppConfig.termsOfServices: (ctx) => const TermsOfServicesScreen(),
        AppConfig.privacyPolicy: (ctx) => const PrivacyPolicyScreen(),
        AppConfig.faq: (ctx) => const FAQScreen(),
        AppConfig.support: (ctx) => const SupportChatScreen(),
        AppConfig.language: (ctx) => const LanguageScreen(),
        AppConfig.subServices: (ctx) =>
            const SubServicesScreen(titleServices: '', listSubServices: []),
        AppConfig.servicesDetail: (ctx) => const ServicesDetailScreen(),
        AppConfig.editMyProject: (ctx) => const EditMyProjectScreen(),
        AppConfig.offerScreen: (ctx) => OffersScreen(
              projectModel: ProjectModel(
                  titleProject: '',
                  categoryProject: '',
                  descriptionProject: '',
                  postBy: '',
                  createdDate: '',
                  numberOfoffers: ''),
            ),
        AppConfig.addProtofilo: (ctx) => const AddProtofiloScreen(),
      },
    );
  }
}
