import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
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
  String userId = 'sc;scds';
  String userAccountType = '';

  getUserStatus() async {
    SharedPrefUser prefs = SharedPrefUser();
    bool currentStatus = await prefs.isLogin();
    String token = await prefs.getToken();
    String _userId = await prefs.getId();
    String _userAccountType = await prefs.getUserAccountType();

    setState(() {
      userStatus = currentStatus;
      userId = _userId;
      log("token $token");

      userAccountType = _userAccountType;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserStatus();
    FirebaseMessaging.instance.subscribeToTopic("BOTH");

    // FirebaseMessaging.instance
    //     .subscribeToTopic("af983750-af6a-4c27-bfc6-bb18c2857f13");
    if (userAccountType.isNotEmpty && userId.isNotEmpty) {
      FirebaseMessaging.instance.subscribeToTopic(userId);
      FirebaseMessaging.instance.subscribeToTopic(userAccountType);
    }

    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => userStatus ? TabScreen() : const LoginScreen(),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    ///forground work
    FirebaseMessaging.onMessage.listen(
      (message) {
        FirebaseMessaging.onMessage.listen((message) {
          if (message.notification != null) {
            log("FirebaseMessaging :  " + message.data.toString());

            Get.rawSnackbar(
              title: message.notification!.title,
              message: message.notification!.body,
              snackPosition: SnackPosition.TOP,
            );
            showTopSnackBar(
              animationDuration: Duration(seconds: 7),
              context,
              Material(
                child: Column(
                  children: [
                    Text("اشعار جديد"),
                    SizedBox(height: 10),
                    CustomSnackBar.success(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      message:
                          "${message.notification!.title} \n  ${message.notification!.body}",
                    ),
                  ],
                ),
              ),
            );
          }
        });
        // NotificationServices().showNotification(
        //   title: message.notification!.title,
        //   body: message.notification!.body,
        // );
        // }
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
