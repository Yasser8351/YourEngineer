import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/model/horizontal_profile.dart';

import '../../widget/shared_widgets/bottom_navigation_card_widget.dart';
import '../../widget/shared_widgets/card_profile_personal_info.dart';
import '../../widget/shared_widgets/list_profile_horizontal.dart';

class ProfileEngineerScreen extends StatefulWidget {
  const ProfileEngineerScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEngineerScreen> createState() => _ProfileEngineerScreenState();
}

class _ProfileEngineerScreenState extends State<ProfileEngineerScreen> {
  var profileList = [
    ListHorizontalProfile(AppConfig.paypal, Icons.payment,
        image: AppImage.paypal),
    ListHorizontalProfile(AppConfig.visa, Icons.visibility,
        image: AppImage.visa),
  ];
  int expandedIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
          child: Column(
            children: [
              CardProfilePersonalInfo(
                size: size,
                colorScheme: colorScheme,
                onTap: () {},
              ),
              const SizedBox(height: 35),
              ListProfileHorizontalWidget(
                isPayScreen: true,
                size: size,
                colorScheme: colorScheme,
                listHorizontalProfile: profileList,
                expandedIndex: expandedIndex,
                onTap: ((index) {
                  setState(() => expandedIndex = index);
                }),
              ),
              BottomNavigationCardWidget(
                size: size,
                colorScheme: colorScheme,
                expandedIndex: expandedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
