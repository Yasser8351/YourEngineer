import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/top_engineer_rating_model.dart';
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
  }

  onProfileTap() {
    if (status == 'ENGINEER') {
      Get.to(() => ProfileEngineerScreen());
      return;
    }
    if (status == 'OWNER') {
      Get.to(() => ProfileUserScreen());
      return;
    }
    if (status == '') {
      Get.to(() => ProfileEngineerScreen());
      return;
    }
  }

  goToEngineerProfile(List<Result> results) {
    Get.to(() => ProfileEngineerScreen());
    return;
  }
}
