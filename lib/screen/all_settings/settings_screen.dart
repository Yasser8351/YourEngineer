import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/screen/project/add_project_screen.dart';
import 'package:your_engineer/screen/project_screen.dart';
import 'package:your_engineer/sharedpref/user_share_pref.dart';

import '../../controller/setting_controller.dart';
import '../../widget/shared_widgets/text_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingControoler controller = Get.put(SettingControoler());

    return Scaffold(
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCardItem(context, AppConfig.profile.tr,
                  Icons.person_pin_outlined, () => controller.onProfileTap()),

              // () => Navigator.of(context).pushNamed(AppConfig.profileUser)),
              buildDivider(),
              buildCardItem(
                  context,
                  AppConfig.notifcation.tr,
                  Icons.notifications_outlined,
                  () => Navigator.of(context).pushNamed(AppConfig.notifcation)),
              buildDivider(),
              buildCardItem(
                  context,
                  AppConfig.myProject.tr,
                  Icons.edit,
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const ProjectScreen(isMyProject: true)))),
              buildDivider(),
              buildCardItem(
                  context,
                  AppConfig.addProjectScreen.tr,
                  Icons.content_paste_go,
                  () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddProjectScreen(),
                      ))),
              // .pushNamed(AppRouting.addProjectScreen)),
              // buildDivider(),
              // buildCardItem(
              //     context,
              //     AppConfig.termsOfServices.tr,
              //     Icons.front_hand_outlined,
              //     () => Navigator.of(context)
              //         .pushNamed(AppRouting.privacyPolicy)),
              // .pushNamed(AppConfig.termsOfServices)),
              buildDivider(),
              buildCardItem(
                context,
                AppConfig.language.tr,
                Icons.change_circle_outlined,
                () => {Navigator.of(context).pushNamed(AppConfig.language)},
              ),
              buildDivider(),
              buildCardItem(
                context,
                AppConfig.faq.tr,
                Icons.note_alt_outlined,
                () => {Navigator.of(context).pushNamed(AppConfig.faq)},
              ),
              buildDivider(),
              buildCardItem(
                context,
                AppConfig.support.tr,
                Icons.support_agent_rounded,
                () => {Navigator.of(context).pushNamed(AppConfig.support)},
              ),
              buildDivider(),
              // buildCardItem(
              //   context,
              //   AppConfig.privacyPolicy,
              //   Icons.security,
              //   () =>
              //       {Navigator.of(context).pushNamed(AppConfig.privacyPolicy)},
              // ),
              // buildDivider(),
              buildCardItem(
                  context,
                  AppConfig.privacyPolicy.tr,
                  Icons.security,
                  () =>
                      Navigator.of(context).pushNamed(AppRouting.privacyPolicy),
                  true),
              buildDivider(),
              buildCardItem(context, AppConfig.logout.tr, Icons.logout,
                  () => logout(context), true),
              buildDivider(),
              const SizedBox(height: 20),
              TextWidget(
                  title: AppConfig.version.tr,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary),
            ],
          ),
        ),
      ),
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.settings.tr, fontSize: 18, color: Colors.white),
      ),
    );
  }

  buildDivider() {
    return const Divider(
      height: 10,
    );
  }

  buildCardItem(
      BuildContext context, String title, IconData icons, Function() onTap,
      [bool isColorRed = false]) {
    return GestureDetector(
      onTap: () => onTap(),
      child: ListTile(
        leading: Icon(icons,
            color: isColorRed
                ? Colors.red
                : Theme.of(context).colorScheme.primary),
        title: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextWidget(
                title: title,
                fontSize: 18,
                color: isColorRed
                    ? Colors.red
                    : Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        trailing: Icon(Icons.navigate_next,
            size: 30, color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  logout(context) async {
    SharedPrefUser sharedPrefUser = SharedPrefUser();
    await sharedPrefUser.logout();
    // Navigator.of(context).pushNamed(AppConfig.login);
    Get.offAllNamed(AppConfig.login);
  }
}
