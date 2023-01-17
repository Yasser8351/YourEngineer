import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/sharedpref/user_share_pref.dart';

import '../model/top_engineer_rating_model.dart';
import '../model/user_model.dart';
import '../screen/profile/profile_engineer_screen.dart';
import '../screen/profile/profile_user_screen.dart';

class SettingControoler extends GetxController {
  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  late SharedPreferences s;
  late var token;
  late var status;

  getUserInfo() async {
    s = await SharedPreferences.getInstance();
    token = await s.getString('token');
    status = await s.getString('status');

    myLog("token", "$token");
    myLog("status", "$status");
  }

  onProfileTap() {
    if (status == 'ENGINEER') {
      Get.to(() => ProfileEngineerScreen(
          engineerModel: TopEngineerRatingModel(results: [])));
      return;
    }
    if (status == 'OWNER') {
      Get.to(() => ProfileUserScreen());
      return;
    }
    if (status == '') {
      Get.to(() => ProfileEngineerScreen(
          engineerModel: TopEngineerRatingModel(results: [])));
      return;
    }
  }
}
