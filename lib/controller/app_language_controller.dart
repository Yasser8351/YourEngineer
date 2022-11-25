import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppLanguageContoller extends GetxController {
  Locale? local;

  changeLanguage(String languageCode) {
    Locale local = Locale(languageCode);
    Get.updateLocale(local);
  }
}
