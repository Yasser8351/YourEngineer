import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/screen/add_project_screen.dart';
import 'package:your_engineer/screen/forgot_password_screen.dart';
import 'package:your_engineer/screen/login_screen.dart';
import 'package:your_engineer/screen/sign_up_screen.dart';

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
          //////////////////////////////
          onError: Colors.black54,
          onBackground: Colors.black,
          error: Colors.white,

          surface: Color.fromARGB(255, 46, 231, 0),
          onSurface: Color.fromARGB(137, 175, 0, 0),
          brightness: Brightness.light,
        ),
        primarySwatch: Colors.blue,
      ),
      home: const TabScreen(),
      routes: {
        AppConfig.login: (ctx) => const LoginScreen(),
        AppConfig.signUp: (ctx) => const SignUpScreen(),
        AppConfig.forgetPassword: (ctx) => const ForgotPasswordScreen(),
        AppConfig.tabScreen: (ctx) => const TabScreen(),
        AppConfig.addProjectScreen: (ctx) => const AddProjectScreen(),
      },
    );
  }
}
