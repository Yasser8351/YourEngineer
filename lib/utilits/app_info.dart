import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';

class AppInfo {
  // String? _buildNumber;
  // Locale? _locale;
  String? _accountType;
  AppInfo._();
  static AppInfo? _instance;
  static AppInfo get instance {
    if (_instance == null) throw 'not init';
    return _instance!;
  }

  static void initAppInfo({
    Locale? currentLocale,
    String? accountType,
  }) {
    _instance ??= AppInfo._();
    _instance!._accountType = accountType;
    // _instance!._locale = currentLocale;
  }

  String get buildNumber => AppConfig.buildNumber;
  String get accountType => _accountType ?? "";
  // String get langCode {
  //   if (_locale == null) return "1";
  //   return _locale!.languageCode == "en" ? "1" : "0";
  // }

  // set locale(Locale locale) {
  //   _locale = locale;
  // }
}
