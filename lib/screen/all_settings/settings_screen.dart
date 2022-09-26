import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/screen/project_screen.dart';

import '../../widget/shared_widgets/text_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCardItem(
                  context,
                  AppConfig.profile,
                  Icons.person_pin_outlined,
                  () => Navigator.of(context).pushNamed(AppConfig.profileUser)),
              buildDivider(),
              buildCardItem(
                  context,
                  AppConfig.notifcation,
                  Icons.notifications_outlined,
                  () => Navigator.of(context).pushNamed(AppConfig.notifcation)),
              buildDivider(),
              buildCardItem(
                  context,
                  AppConfig.myProject,
                  Icons.edit,
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const ProjectScreen(isMyProject: true)))),
              buildDivider(),
              buildCardItem(
                  context,
                  AppConfig.addProjectScreen,
                  Icons.content_paste_go,
                  () => Navigator.of(context)
                      .pushNamed(AppConfig.addProjectScreen)),
              buildDivider(),
              buildCardItem(
                  context,
                  AppConfig.termsOfServices,
                  Icons.front_hand_outlined,
                  () => Navigator.of(context)
                      .pushNamed(AppConfig.termsOfServices)),
              buildDivider(),
              buildCardItem(
                context,
                AppConfig.privacyPolicy,
                Icons.security,
                () =>
                    {Navigator.of(context).pushNamed(AppConfig.privacyPolicy)},
              ),
              buildDivider(),
              buildCardItem(
                context,
                AppConfig.language,
                Icons.change_circle_outlined,
                () => {Navigator.of(context).pushNamed(AppConfig.language)},
              ),
              buildDivider(),
              buildCardItem(
                context,
                AppConfig.faq,
                Icons.note_alt_outlined,
                () => {Navigator.of(context).pushNamed(AppConfig.faq)},
              ),
              buildDivider(),
              buildCardItem(
                context,
                AppConfig.support,
                Icons.support_agent_rounded,
                () => {Navigator.of(context).pushNamed(AppConfig.support)},
              ),
              buildDivider(),
              buildCardItem(context, AppConfig.logout, Icons.logout,
                  () => Navigator.of(context).pushNamed(AppConfig.login), true),
              buildDivider(),
              const SizedBox(height: 20),
              TextWidget(
                  title: AppConfig.version,
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
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.settings, fontSize: 18, color: Colors.white),
      ),
      // leading: IconButton(
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      //   icon: const Icon(Icons.navigate_before, size: 40),
      //   color: Colors.white,
      // ),
    );
  }

  buildDivider() {
    return const Divider(
      height: 10,
    );
  }

  buildCardItem(
      BuildContext context, String title, IconData icons, Function() onTap,
      [bool isLogout = false]) {
    return GestureDetector(
      onTap: () => onTap(),
      child: ListTile(
        leading: Icon(icons,
            color:
                isLogout ? Colors.red : Theme.of(context).colorScheme.primary),
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextWidget(
                title: title,
                fontSize: 18,
                color: isLogout
                    ? Colors.red
                    : Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        trailing: Icon(Icons.navigate_next,
            size: 30,
            color: isLogout
                ? Colors.red
                : Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
