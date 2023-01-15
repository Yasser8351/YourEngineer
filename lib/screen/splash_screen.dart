import 'dart:async';

import 'package:flutter/material.dart';
import 'package:your_engineer/screen/tab_screen.dart';

import '../app_config/app_image.dart';
import '../sharedpref/user_share_pref.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userStatus = false;

  getUserStatus() async {
    SharedPrefUser prefs = SharedPrefUser();
    bool currentStatus = await prefs.isLogin();

    setState(() {
      userStatus = currentStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserStatus();

    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              userStatus ? const TabScreen() : const LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: const Color(0xFF25366C),
      body: Center(
        // child: CircleAvatar(
        //   // maxRadius: 55,
        //   // backgroundColor: Theme.of(context).colorScheme.primary,
        //   // child:
        child: Image.asset(
          AppImage.logo,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          // maxRadius: 40,
          // backgroundColor: Theme.of(context).colorScheme.primary,
          // backgroundImage: const AssetImage(
          //   AppImage.logo,
          // ),
          // child: const Text(
          //   "Logo",
          //   style: TextStyle(color: Colors.white),
          // ),
        ),
      ),
      // ),
    );
  }
}
