import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  AppConfig.emal,
                  //style: AppStyle.textSettingsScreenScreenTitle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 14),
                  buildCardItem(context, AppConfig.signUp, Icons.verified_user,
                      () => Navigator.of(context).pushNamed(AppConfig.login)),
                  buildDivider(),
                  buildCardItem(context, AppConfig.emal, Icons.front_hand,
                      () => Navigator.of(context).pushNamed(AppConfig.login)),
                  const SizedBox(height: 14),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 14),
                  buildCardItem(context, AppConfig.emal, Icons.star, () => {}),
                  buildDivider(),
                  buildCardItem(context, AppConfig.emal, Icons.phone, () => {}),
                  buildDivider(),
                  buildCardItem(context, AppConfig.emal, Icons.app_settings_alt,
                      () => Navigator.of(context).pushNamed(AppConfig.login)),
                  buildDivider(),
                  buildCardItem(context, AppConfig.emal, Icons.share_outlined,
                      () async {
                    // await Share.share(AppConfig.shareDiscreption);
                  }),
                  buildDivider(),

                  // buildDivider(),
                  // buildCardItem(
                  //     context,
                  //     AppConfig.snedNotifcation,
                  //     Icons.send,
                  //     () => Navigator.of(context)
                  //         .pushNamed(SnedNotifcationScreen.routeName)),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

buildDivider() {
  return const Divider(
    height: 30,
  );
}

buildCardItem(
    BuildContext context, String title, IconData icons, Function() onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.navigate_before, size: 27, color: Colors.grey.shade600),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                // style: AppStyle.textSettingsScreenScreenScendry
              ),
              const SizedBox(width: 16),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffFD4C4C),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  height: 30,
                  width: 30,
                  child: Icon(icons, size: 17, color: Colors.white)),
            ],
          ),
        ],
      ),
    ),
  );
}

buildCardAboutApp(
    BuildContext context, String title, String icons, Function() onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            " ${AppConfig.emal} ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 29, 29, 29),
                ),
              ),
              const SizedBox(width: 16),
              // Image.asset(
              //   AppConfig.logoWithoutBackgroundPng,
              //   height: 30,
              //   width: 30,
              // ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffFD4C4C),
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 30,
                width: 30,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    // child: SvgPicture.asset(
                    //   icons,
                    //   // height: 205,
                    //   // width: 205,
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
