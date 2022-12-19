import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../app_config/app_config.dart';
import '../controller/app_language_controller.dart';
import '../widget/shared_widgets/text_widget.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLanguageContoller appLanguageContoller = AppLanguageContoller();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.04,
          ),
          _buildLanguageButtonItem(
            title: 'العربية',
            onTap: () {
              appLanguageContoller.changeLanguage('ar');
              // localeProvider.setLocale(L10n.all[1]);
              // print(localeProvider.locale.toString());
            },
          ),
          _buildLanguageButtonItem(
            title: 'English',
            onTap: () {
              appLanguageContoller.changeLanguage('en');
              // localeProvider.setLocale(L10n.all[0]);
              // print(localeProvider.locale.toString());
            },
          ),
        ],
      ),
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.language.tr, fontSize: 18, color: Colors.white),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.navigate_before, size: 40),
        color: Colors.white,
      ),
    );
  }

  InkWell _buildLanguageButtonItem({
    required String title,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 70,
        child: Material(
          elevation: 7,
          shadowColor: Colors.white30,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
